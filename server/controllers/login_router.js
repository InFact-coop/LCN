const isLoggedIn = (req, res, next) => {
  if (req.isAuthenticated()) return next();
  res.redirect('/');
};

module.exports = (app, passport) => {
  app.get('/', (req, res) => {
    res.render('login', { message: req.flash('loginMessage') });
  });

  // app.post('/login',);
  app.post(
    '/signup',
    passport.authenticate('local-signup', {
      successRedirect: '/app',
      failureRedirect: '/signup',
      failureFlash: true
    })
  );

  app.get('/signup', function(req, res) {
    res.render('signup', { message: req.flash('signupMessage') });
  });

  app.get('/app', isLoggedIn, (req, res) => {
    res.render('app.hbs', {
      user: req.user
    });
  });

  app.get('/logout', (req, res) => {
    req.logout();
    res.redirect('/');
  });
};
