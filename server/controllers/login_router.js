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

  app.get('/signup', function(req, res) {
    res.render('signup', { message: req.flash('signupMessage') });
  });

  app.get('/logout', (req, res) => {
    req.logout();
    res.redirect('/');
  });
};
