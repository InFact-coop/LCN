const r = require('ramda');

const User = require('../models/user');

const { is_logged_in, is_admin } = require('./route_middleware');
const { generate_random_token, parse_date } = require('../helpers');
const { send_invite_email } = require('../helpers/email_helpers');
const {
  create_user_with_signup_token,
  update_user_signup_token
} = require('../helpers/db_helpers');

const search_for_existing_user = email => {
  return new Promise((resolve, reject) => {
    User.findOne({ email: email }, (err, user) => {
      if (err) return reject(err);
      if (!user) return resolve({ [email]: {} });
      resolve({ [user.email]: user });
    });
  });
};

const invite_new_user = async ({ email, name }) => {
  const token = await generate_random_token();
  const user = await create_user_with_signup_token({ email, name, token });
  return send_invite_email({ user, token });
};

const invite_existing_user = async user => {
  const token = await generate_random_token();
  const updated_user = await update_user_signup_token({ user, token });
  return send_invite_email({ user: updated_user, token });
};

module.exports = app => {
  app.get('/invite-users', async (req, res) => {
    // app.get('/invite-users', is_logged_in, is_admin, async (req, res) => {
    res.render('invite-users');
  });

  // app.post('/invite-users', is_logged_in, is_admin, async (req, res) => {
  app.post('/invite-users', async (req, res) => {
    const submitted_users_by_email = r.reduce(
      (acc, user_obj) => {
        return user_obj.email === ''
          ? acc
          : { ...acc, [user_obj.email]: user_obj };
      },
      {},
      r.values(req.body)
    );

    const users_from_database = await Promise.all(
      r.map(search_for_existing_user, r.keys(submitted_users_by_email))
    ).catch(err => {
      console.log('invite users err', err);
      return res.status(400).render('error', {
        message:
          'Something went wrong inviting the users, please try again in a few minutes.'
      });
    });

    const already_signed_up_users = r.pipe(
      r.filter(r.prop('signed_up')),
      r.keys,
      r.map(email => submitted_users_by_email[email])
    )(r.mergeAll(users_from_database));

    const new_users_to_invite = r.pipe(
      r.filter(r.isEmpty),
      r.keys,
      r.map(email => submitted_users_by_email[email])
    )(r.mergeAll(users_from_database));

    const existing_users_to_invite = r.pipe(
      r.filter(
        user_obj =>
          user_obj.signed_up === false &&
          parse_date(user_obj.signup_expires) < Date.now()
      ),
      r.values
    )(r.mergeAll(users_from_database));

    const invite_new_users = r.map(invite_new_user, new_users_to_invite);

    const invite_existing_users = r.map(
      invite_existing_user,
      existing_users_to_invite
    );

    await Promise.all([...invite_new_users, ...invite_existing_users]).catch(
      err => {
        console.log('invite users err', err);
        return res.status(400).render('error', {
          message:
            'Something went wrong inviting the users, please try again in a few minutes.'
        });
      }
    );

    // console.log('new users to invite', new_users_to_invite);
    // console.log('already_signed_up_users', already_signed_up_users);
    // console.log('existing_users_to_invite', existing_users_to_invite);

    const results = () => {
      const users_invited = r.map(
        user_obj => submitted_users_by_email[user_obj.email]
      )([...new_users_to_invite, ...existing_users_to_invite]);

      const users_already_invited = r.without(
        [...already_signed_up_users, ...users_invited],
        r.values(submitted_users_by_email)
      );

      return {
        already_signed_up_users,
        users_invited,
        users_already_invited
      };
    };

    res.render('invite-users', { results: results() });
  });
};
