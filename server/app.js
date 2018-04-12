require('../config.js');
const path = require('path');
const exphbs = require('express-handlebars');
const express = require('express');

// Express Middleware
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const passport = require('passport');
const flash = require('connect-flash');
const session = require('express-session');
const morgan = require('morgan');

// Custom Stuff
const api_router = require('./routers/api');
const auth_router = require('./routers/auth');
const admin_router = require('./routers/admin');

const configDB = require('./config/database.js');
const helpers = require('./helpers.js');

const app = express();

mongoose.connect(configDB.url);
require('./config/passport')(passport);

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
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

app.set('view engine', 'hbs');
app.set('views', path.join(__dirname, 'views'));
app.engine(
  'hbs',
  exphbs({
    extname: 'hbs',
    layoutsDir: path.join(__dirname, 'views', 'layouts'),
    partialsDir: path.join(__dirname, 'views', 'partials'),
    defaultLayout: 'main',
    helpers: helpers
  })
);

app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
  })
);
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());
app.use(morgan('dev'));

// Our Routers
app.use('/api/v1/', api_router);
app.use(express.static(path.join(__dirname, '../public')));
auth_router(app, passport);
admin_router(app);

module.exports = app;
