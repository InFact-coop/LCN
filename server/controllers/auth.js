const User = require('../models/user');
const crypto = require('crypto');
const smtpTransport = require('../config/nodemailer');
const db_helpers = require('../helpers/db_helpers');

const signup_get = (req, res) => {
  if (!req.query.token) {
    return res.status(400).render('error', {
      message:
        'To sign up to this service, please get in touch with LCN who will be able to provide an invitation email.'
    });
  }

  db_helpers
    .find_user({
      signup_token: req.query.token,
      signup_expires: {
        $gt: Date.now()
      }
    })
    .then(user => {
      res.render('signup', {
        message: req.flash('signupMessage'),
        token: req.query.token
      });
    })
    .catch(err => {
      console.log('sign up err', err);
      return res.status(400).render('error', {
        message:
          'Sign up link is invalid or has expired. Please request another one.'
      });
    });
};

const signup_post = passport => (req, res, next) => {
  console.log('in here');
  const redirectURL = `/signup?token=${req.body.token}`;
  passport.authenticate('signup', (err, user, info) => {
    console.log('in auth');
    if (err) {
      return res.status(400).render('error', {
        message:
          'Something went wrong signing up, please try again in a few minutes'
      });
    }
    if (!user) {
      return res.redirect(redirectURL);
    }
    res.redirect('/');
  })(req, res, next);
};

const login_get = (req, res) => {
  res.render('login', { message: req.flash('loginMessage') });
};

const login_post = passport => {
  return passport.authenticate('login', {
    successRedirect: '/',
    failureRedirect: '/',
    failureFlash: true
  });
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
        token: req.query.token,
        message: req.flash('resetPasswordMessage')
      });
    } else {
      return res.status(400).render('error', {
        message:
          'Password reset link is invalid or has expired. Please request another one.'
      });
    }
  });
};

const reset_password_post = (req, res) => {
  const redirectURL = `/reset-password?token=${req.body.token}`;
  User.findOne({
    reset_password_token: req.body.token,
    reset_password_expires: {
      $gt: Date.now()
    }
  }).exec((err, user) => {
    if (!err && !user) {
      req.flash(
        'resetPasswordMessage',
        'Password token is invalid or has expired. Please send another.'
      );
      return res.redirect(redirectURL);
    }
    if (req.body.password !== req.body.confirmPassword) {
      req.flash('resetPasswordMessage', 'Passwords do not match');
      return res.redirect(redirectURL);
    }
    user.password = user.generateHash(req.body.password);
    user.reset_password_token = undefined;
    user.reset_password_expires = undefined;
    user.save(err => {
      if (err) {
        req.flash(
          'resetPasswordMessage',
          'Oops, looks like we had trouble resetting your password. Please try again in a few minutes.'
        );
        console.log('422 ERROR: ', err);
        return res.redirect(redirectURL);
      }
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
        if (err) {
          console.log('422 ERROR SENDING SUCCESS MAIL: ', err);
        }
        req.flash('loginMessage', 'Password successfully reset. Please login');
        return res.redirect('/');
      });
    });
  });
};

const forgot_password_get = (req, res) => {
  res.render('forgot-password', {
    message: req.flash('forgotPasswordMessage')
  });
};

const forgot_password_post = (req, res) => {
  User.findOne({
    email: req.body.email
  })
    .then(user => {
      return new Promise((resolve, reject) => {
        if (!user) return reject('Sorry, but that user does not exist');
        crypto.randomBytes(20, (err, buffer) => {
          if (err) {
            console.log('Error generating random token: ', err);
            return reject(
              'Sorry, but there seems to have been a problem on our end. Please try again in a few minutes or contact LCN'
            );
          }
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
            req.flash(
              'loginMessage',
              'Kindly check your email for further instructions'
            );
            return res.redirect('/');
          } else {
            console.log('Error sending reset email: ', err);
            return reject(
              'Sorry, we seem to have had a problem sending you a password reset email. Please try again in a few minutes.'
            );
          }
        });
      });
    })
    .catch(err => {
      console.log('err', err);
      req.flash('forgotPasswordMessage', err);
      return res.redirect('/forgot-password');
    });
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
  login_post,
  signup_post
};
