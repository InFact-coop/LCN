const User = require("../models/user");

const find_user = search_params => {
  return new Promise((resolve, reject) => {
    User.findOne(search_params).exec((err, user) => {
      if (err) return reject(err);
      if (!user) return reject("No user found");
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
    user.signup_expires = Date.now() + 7 * 24 * 60 * 60 * 1000;
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
        signup_expires: Date.now() + 7 * 24 * 60 * 60 * 1000
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

const search_for_existing_user = email => {
  return new Promise((resolve, reject) => {
    User.findOne({ email: email }, (err, user) => {
      if (err) return reject(err);
      if (!user) return resolve({ [email]: {} });
      resolve({ [user.email]: user });
    });
  });
};

const update_user_comments_liked = (user, commentId) => {
  return new Promise((resolve, reject) => {
    User.findByIdAndUpdate(
      { _id: user._id },
      {
        $push: { comments_liked: commentId }
      }
    ).exec((err, user) => {
      if (!user) return reject("No user found");
      if (err) return reject(err);
      resolve(true);
    });
  });
};

const check_user_commented = user => {
  return new Promise((resolve, reject) => {
    User.findOne({ _id: user._id }).exec((err, user) => {
      if (!user) return reject("No user found");
      if (err) return reject(err);
      resolve(user.comments_liked);
    });
  });
};
module.exports = {
  create_user_with_signup_token,
  update_user_signup_token,
  find_user,
  search_for_existing_user,
  update_user_comments_liked,
  check_user_commented
};
