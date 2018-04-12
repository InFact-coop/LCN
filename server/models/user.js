const mongoose = require('mongoose');
const bcrypt = require('bcrypt-nodejs');

var userSchema = mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, default: null },
  full_name: { type: String, required: true },
  reset_password_token: { type: String, default: null },
  reset_password_expires: { type: Date, default: null },
  admin: { type: Boolean, default: false },
  signup_token: { type: String, default: null },
  signup_expires: { type: Date, default: null },
  signed_up: { type: Boolean, default: false }
});

userSchema.methods.generateHash = function(password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

userSchema.methods.validPassword = function(password) {
  return bcrypt.compareSync(password, this.password);
};

module.exports = mongoose.model('User', userSchema);
