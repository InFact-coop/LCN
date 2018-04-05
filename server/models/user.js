const mongoose = require('mongoose');
const bcrypt = require('bcrypt-nodejs');

var userSchema = mongoose.Schema({
  email: String,
  password: String,
  reset_password_token: String,
  reset_password_expires: Date
});

userSchema.methods.generateHash = function(password) {
  return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

userSchema.methods.validPassword = function(password) {
  return bcrypt.compareSync(password, this.password);
};

module.exports = mongoose.model('User', userSchema);
