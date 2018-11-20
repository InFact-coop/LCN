const is_logged_in = (req, res, next) => {
  if (req.isAuthenticated()) return next();
  if (req.query.token) res.redirect(`/onboarding?token=${req.query.token}`);
  res.redirect("/onboarding");
};

const is_admin = (req, res, next) => {
  if (req.user.admin === true) return next();
  res.redirect("/");
};

module.exports = {
  is_logged_in,
  is_admin
};
