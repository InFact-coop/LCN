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
    new LocalStrategy(
      {
        usernameField: 'email',
        passwordField: 'password',
        passReqToCallback: true
      },
      function(req, email, password, done) {
        console.log('in here');
        process.nextTick(function() {
          User.findOne({ email: email }, function(err, user) {
            if (err) {
              console.log('err', 'err');
              return done(err);
            }
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
};
