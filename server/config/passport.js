const LocalStrategy = require('passport-local').Strategy;
const User = require('../models/user');

module.exports = function(passport) {
  passport.serializeUser(function(user, done) {
    done(null, user.id);
  });

  passport.deserializeUser(function(id, done) {
    User.findById(id, function(err, user) {
      done(err, user);
    });
  });

  passport.use(
    'signup',
    new LocalStrategy(
      {
        usernameField: 'email',
        passwordField: 'password',
        passReqToCallback: true
      },
      function(req, email, password, done) {
        if (password !== req.body.confirmPassword) {
          return done(
            null,
            false,
            req.flash('signupMessage', 'Passwords do not match')
          );
        }
        User.findOne({ email: email }).then(user => {
          User.findOneAndUpdate(
            { email: email },
            {
              password: user.generateHash(password),
              full_name: req.body.full_name,
              signed_up: true,
              signup_expires: null,
              signup_token: null
            },
            { new: true },
            (err, updated_user) => {
              if (err) return done(err);
              return done(null, updated_user);
            }
          );
        });
      }
    )
  );

  passport.use(
    'login',
    new LocalStrategy(
      {
        usernameField: 'email',
        passwordField: 'password',
        passReqToCallback: true
      },
      function(req, email, password, done) {
        User.findOne({ email: email }, function(err, user) {
          if (err) return done(err);
          if (!user) {
            return done(
              null,
              false,
              req.flash('loginMessage', 'No user found')
            );
          }
          if (!user.validPassword(password)) {
            return done(
              null,
              false,
              req.flash('loginMessage', 'Oops! Wrong password.')
            );
          }
          return done(null, user);
        });
      }
    )
  );
};
