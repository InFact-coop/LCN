const User = require('../models/user');
const crypto = require('crypto');
const smtpTransport = require('../config/nodemailer');

const is_logged_in = (req, res, next) => {
  if (req.isAuthenticated()) return next();
  res.redirect('/login');
};

const login_post = passport => {
  return passport.authenticate('login', {
    successRedirect: '/',
    failureRedirect: '/',
    failureFlash: true
  });
};

const signup_post = passport => {
  return passport.authenticate('signup', {
    successRedirect: '/',
    failureRedirect: '/signup',
    failureFlash: true
  });
};

const login_get = (req, res) => {
  res.render('login', { message: req.flash('loginMessage') });
};

const home_get = (req, res) => {
  res.render('app', {
    user: req.user
  });
};

const reset_password_get = (req, res) => {
  User.findOne({
    reset_password_token: req.query.token,
    reset_password_expires: {
      $gt: Date.now()
    }
  }).exec((err, user) => {
    if (!err && user) {
      res.render('reset-password', {
        token: req.query.token
      });
    } else {
      return res.status(400).send({
        message:
          'Password reset token is invalid or has expired. Please send another.'
      });
    }
  });
};

const reset_password_post = (req, res, next) => {
  User.findOne({
    reset_password_token: req.body.token,
    reset_password_expires: {
      $gt: Date.now()
    }
  }).exec((err, user) => {
    if (!err && !user) {
      return res.status(400).send({
        message:
          'Password reset token is invalid or has expired. Please send another.'
      });
    }
    if (req.body.newPassword !== req.body.verifyPassword) {
      return res.status(422).send({ message: 'Passwords do not match' });
    }
    user.password = user.generateHash(req.body.newPassword);
    user.reset_password_token = undefined;
    user.reset_password_expires = undefined;
    user.save(err => {
      if (err) return res.status(422).send({ message: err });
      const data = {
        to: user.email,
        from: process.env.MAILER_EMAIL_ID,
        template: 'reset-password-email',
        subject: 'Password Reset Confirmation',
        context: {
          name: user.full_name.split(' ')[0]
        }
      };

      smtpTransport.sendMail(data, err => {
        if (err) return res.status(422).send({ message: err });
        return res.json({ message: 'Password successfully reset' });
      });
    });
  });
};

const forgot_password_get = (req, res) => {
  res.render('forgot-password');
};

const forgot_password_post = (req, res) => {
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
    .then(updatedUser => {
      const data = {
        to: updatedUser.email,
        from: process.env.MAILER_EMAIL_ID,
        template: 'forgot-password-email',
        subject: 'Password help has arrived!',
        context: {
          url:
            'http://localhost:4000/reset-password?token=' +
            updatedUser.reset_password_token,
          name: updatedUser.full_name.split(' ')[0]
        }
      };

      return new Promise((resolve, reject) => {
        smtpTransport.sendMail(data, err => {
          if (!err) {
            return res.json({
              message: 'Kindly check your email for further instructions'
            });
          }
          return reject(err);
        });
      });
    })
    .catch(err => {
      console.log('err', err);
      return res.status(422).json({ message: err });
    });
};

const signup_get = (req, res) => {
  res.render('signup', { message: req.flash('signupMessage') });
};

const logout_get = (req, res) => {
  req.logout();
  res.redirect('/');
};

module.exports = {
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
};