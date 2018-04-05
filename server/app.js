require('../config.js');
const path = require('path');
const exphbs = require('express-handlebars');
const express = require('express');

// Express Middleware
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const mongoose = require('mongoose');
const passport = require('passport');
const flash = require('connect-flash');
const session = require('express-session');
const morgan = require('morgan');

// Custom Stuff
const api_router = require('./controllers/api_router');
const login_router = require('./controllers/login_router');
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

// app.use(https_redirect);
app.use(express.static(path.join(__dirname, '../../public')));
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

// app.use(cookieParser());

// Our Routers
// app.use('/api/v1/', api_router);
login_router(app, passport);
module.exports = app;
