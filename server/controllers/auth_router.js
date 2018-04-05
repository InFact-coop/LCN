const User = require('../models/user');
const crypto = require('crypto');

const isLoggedIn = (req, res, next) => {
  if (req.isAuthenticated()) return next();
  res.redirect('/login');
};

module.exports = (app, passport) => {
  app.get('/login', (req, res) => {
    res.render('login', { message: req.flash('loginMessage') });
  });

  app.get('/', isLoggedIn, (req, res) => {
    res.render('app', {
      user: req.user
    });
  });

  app.post(
    '/login',
    passport.authenticate('login', {
      successRedirect: '/',
      failureRedirect: '/',
      failureFlash: true
    })
  );
  app.post(
    '/signup',
    passport.authenticate('signup', {
      successRedirect: '/',
      failureRedirect: '/signup',
      failureFlash: true
    })
  );
  app.get('/forgot_password', (req, res) => {
    res.render('forgot-password');
  });
  app.post('/forgot_password', (req, res) => {
    User.findOne({
      email: req.body.email
    })
      .then(user => {
        return new Promise((resolve, reject) => {
          if (!user) return reject('Sorry, but that user does not exist');
          crypto.randomBytes(20, (err, buffer) => {
            if (err) return reject(err);
            const token = buffer.toString('hex');
            return resolve({ token, user });
          });
        });
      })
      .then(({ token, user }) => {
        return User.findByIdAndUpdate(
          { _id: user._id },
          {
            reset_password_token: token,
            reset_password_expires: Date.now() + 24 * 60 * 60 * 1000
          },
          { upsert: true, new: true }
        );
      })
      .then(user => {
        console.log('User', user);
      })
      .catch(err => console.log('err', err));
  });
  app.get('/signup', (req, res) => {
    res.render('signup', { message: req.flash('signupMessage') });
  });

  app.get('/logout', (req, res) => {
    req.logout();
    res.redirect('/');
  });
};
