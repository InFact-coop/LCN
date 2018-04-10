const User = require('../models/user');
const {
  login_get,
  home_get,
  reset_password_get,
  reset_password_post,
  forgot_password_get,
  forgot_password_post,
  signup_get,
  logout_get,
  is_logged_in,
  login_post,
  signup_post
} = require('../controllers/auth');

module.exports = (app, passport) => {
  app.get('/login', login_get);
  app.get('/', is_logged_in, home_get);
  app.post('/login', login_post(passport));
  app.post('/signup', signup_post(passport));
  app.get('/reset-password', reset_password_get);
  app.post('/reset-password', reset_password_post);
  app.get('/forgot-password', forgot_password_get);
  app.post('/forgot-password', forgot_password_post);
  app.get('/signup', signup_get);
  app.get('/logout', logout_get);
};
