const User = require('../models/user');
const { is_logged_in, is_admin } = require('./route_middleware');
const r = require('ramda');
const crypto = require('crypto');
const smtpTransport = require('../config/nodemailer');
const helpers = require('../helpers');

const generate_random_token = () => {
  return new Promise((resolve, reject) => {
    crypto.randomBytes(20, (err, buffer) => {
      if (err) {
        console.log('Error generating random token: ', err);
        return reject(err);
      }
      const token = buffer.toString('hex');
      return resolve(token);
    });
  });
};

// TODO: possibly add expiry time for signup_token
const create_user_with_sign_up_token = ({ token, email, name }) => {
  return new Promise((resolve, reject) => {
    const user = new User();
    user.email = email;
    user.full_name = name;
    user.signup_token = token;
    // TODO: change expiry date to a week
    user.signup_expires = Date.now() + 60 * 1000;
    user.save(function(err) {
      if (err) {
        return reject(err);
      }
      return resolve(user);
    });
  });
};

const send_invite_email = ({ user, token }) => {
  const data = {
    to: user.email,
    from: process.env.MAILER_EMAIL_ID,
    template: 'sign-up-email',
    subject: "You've signed up",
    context: {
      name: user.full_name.split(' ')[0]
    }
  };

  smtpTransport.sendMail(data, err => {
    if (err) {
      return reject(err);
    }
    req.flash(
      'loginMessage',
      'Kindly check your email for further instructions'
    );

    return resolve();
  });
};

const invite_user = async ({ email, name }) => {
  const token = await generate_random_token();
  const user = await create_user_with_sign_up_token({ email, name, token });
  return send_invite_email({ user, token });
};

const find_by_email = email => {
  return new Promise((resolve, reject) => {
    User.findOne({ email: email }, (err, user) => {
      if (err) return reject(err);
      if (!user) return resolve({ [email]: {} });
      resolve({ [user.email]: user });
    });
  });
};

module.exports = app => {
  // app.get('/invite-users', is_logged_in, is_admin, (req, res) => {
  app.get('/invite-users', (req, res) => {
    res.render('invite-users');
  });

  // app.post('/invite-users', is_logged_in, is_admin, (req, res) => {
  app.post('/invite-users', async (req, res) => {
    const mock_data = {
      user1: { name: 'Ivan', email: 'ivangonzalez@rocketmail.com' },
      user2: { name: 'Max', email: 'max@email.com' },
      user3: { name: 'Ivan', email: 'ivan@infactcoop.com' },
      user4: { name: 'Matthew', email: 'matthew@email.com' },
      user5: { name: '', email: '' }
    };

    const submitted_users_by_email = r.reduce(
      (acc, user_obj) => {
        return user_obj.email === ''
          ? acc
          : { ...acc, [user_obj.email]: user_obj };
      },
      {},
      // r.values(req.body)
      r.values(mock_data)
    );

    const users_from_database = await Promise.all(
      r.map(find_by_email, r.keys(submitted_users_by_email))
    );
    console.log('users from database', users_from_database);

    // TODO: may be able to get rid of this as signup_expires will always be set when making a user
    // I could have a look at making it a required field when the time comes

    const parse_date = date => {
      if (!date) return 0;
      return Date.parse(date);
    };

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
          parse_date(user_obj.signed_up) < Date.now()
      ),
      r.keys,
      r.map(email => submitted_users_by_email[email])
    )(r.mergeAll(users_from_database));

    console.log('users to invite', new_users_to_invite);
    console.log('signed up users', already_signed_up_users);
    console.log('existing users to invite', existing_users_to_invite);

    Promise.all(r.map(invite_user, new_users_to_invite))
      .then(() => res.redirect('/'))
      .catch(err => console.log('Invite user err', err));

    // const users = await Promise.all[]
    // check whether users already have a sign up link
    // check whether users have already signed up
    // sign up remaining users
    // return list of signed up users, of already signed up users and of users already sent an invite
  });
};
