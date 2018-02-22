require('../../config.js');
const express = require('express');
const bodyParser = require('body-parser');
const api_router = require('./routers/api_router');
const path = require('path');

const app = express();

// force heroku to use https

const https_redirect = (req, res, next) => {
  if (process.env.NODE_ENV === 'production') {
    if (req.headers['x-forwarded-proto'] != 'https') {
      return res.redirect(`https://${req.headers.host}${req.url}`);
    } else {
      return next();
    }
  } else {
    return next();
  }
};

app.use(https_redirect);
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, '../../public')));

app.use('/api/v1/', api_router);

module.exports = app;
