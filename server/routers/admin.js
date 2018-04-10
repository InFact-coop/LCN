const { is_logged_in, is_admin } = require('./route_middleware');

module.exports = app => {
  app.get('/invite-users', is_logged_in, is_admin, (req, res) => {
    res.render('invite-users', { user: req.user });
  });
};
