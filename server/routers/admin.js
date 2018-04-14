const { invite_users_get, invite_users_post } = require('../controllers/admin');

const { is_logged_in, is_admin } = require('./route_middleware');

module.exports = app => {
  app.get('/invite-users', is_logged_in, is_admin, invite_users_get);
  app.post('/invite-users', is_logged_in, is_admin, invite_users_post);
};
