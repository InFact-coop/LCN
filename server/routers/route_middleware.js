const is_logged_in = (req, res, next) => {
  if (req.isAuthenticated()) return next();
  res.redirect('/login');
};

const is_admin = (req, res, next) => {
  if (req.user.admin === true) return next();
  res.redirect('/');
};

module.exports = {
  is_logged_in,
  is_admin
};
