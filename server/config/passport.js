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
        process.nextTick(function() {
          User.findOne({ email: email }, function(err, user) {
            if (err) return done(err);
            if (user) {
              return done(
                null,
                false,
                req.flash('signupMessage', 'That email is already taken.')
              );
            } else {
              const newUser = new User();

              newUser.email = email;
              newUser.password = newUser.generateHash(password);
              newUser.full_name = req.body.full_name;
              newUser.signed_up = true;
              newUser.signup_expires = null;

              newUser.save(function(err) {
                if (err) {
                  console.log('err', err);
                  throw err;
                }
                return done(null, newUser);
              });
            }
          });
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
          if (!user)
            return done(
              null,
              false,
              req.flash('loginMessage', 'No user found')
            );
          if (!user.validPassword(password))
            return done(
              null,
              false,
              req.flash('loginMessage', 'Oops! Wrong password.')
            );
          return done(null, user);
        });
      }
    )
  );
};
