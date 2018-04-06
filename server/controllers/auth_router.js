const User = require('../models/user');
const crypto = require('crypto');
const smtpTransport = require('../config/nodemailer');

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

  app.get('/reset-password', (req, res) => {
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
  });

  app.post('/reset-password', (req, res, next) => {
    console.log('req.body', req.body);
    User.findOne({
      reset_password_token: req.body.token,
      reset_password_expires: {
        $gt: Date.now()
      }
    }).exec((err, user) => {
      if (!err && user) {
        if (req.body.newPassword === req.body.verifyPassword) {
          user.generateHash(req.body.newPassword);
          user.reset_password_token = undefined;
          user.reset_password_expires = undefined;
          user.save(err => {
            if (err) {
              return res.status(422).send({
                message: err
              });
            } else {
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
                if (!err) {
                  return res.json({ message: 'Password successfully reset' });
                } else {
                  return res.status(422).send({ message: err });
                }
              });
            }
          });
        } else {
          return res.status(422).send({
            message: 'Passwords do not match'
          });
        }
      } else {
        return res.status(400).send({
          message:
            'Password reset token is invalid or has expired. Please send another.'
        });
      }
    });
  });

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
            } else {
              return reject(err);
            }
          });
        });
      })
      .catch(err => {
        console.log('err', err);
        return res.status(422).json({ message: err });
      });
  });

  app.get('/signup', (req, res) => {
    res.render('signup', { message: req.flash('signupMessage') });
  });

  app.get('/logout', (req, res) => {
    req.logout();
    res.redirect('/');
  });
};
