const User = require('../models/user');

const find_user = search_params => {
  return new Promise((resolve, reject) => {
    User.findOne(search_params).exec((err, user) => {
      if (err) return reject(err);
      if (!user) return reject('No user found');
      return resolve(user);
    });
  });
};

const create_user_with_signup_token = ({ token, email, name }) => {
  return new Promise((resolve, reject) => {
    const user = new User();
    user.email = email;
    user.full_name = name;
    user.signup_token = token;
    // TODO: change expiry date to a week
    user.signup_expires = Date.now() + 2 * 60 * 1000;
    user.save(function(err, updated_user) {
      if (err) {
        return reject(err);
      }
      return resolve(updated_user);
    });
  });
};

const update_user_signup_token = ({ user, token }) => {
  return new Promise((resolve, reject) => {
    User.findByIdAndUpdate(
      { _id: user._id },
      {
        signup_token: token,
        // TODO: change expiry date to a week
        signup_expires: Date.now() + 4 * 60 * 1000
      },
      { new: true },
      (err, updated_user) => {
        if (err) {
          return reject(err);
        }
        return resolve(updated_user);
      }
    );
  });
};

module.exports = {
  create_user_with_signup_token,
  update_user_signup_token,
  find_user
};
