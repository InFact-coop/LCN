const crypto = require('crypto');

const getToday = () => {
  let today = new Date();
  let dd = today.getDate();
  let mm = today.getMonth() + 1; //January is 0!

  let yyyy = today.getFullYear();
  if (dd < 10) {
    dd = `0${dd}`;
  }
  if (mm < 10) {
    mm = `0${mm}`;
  }
  today = `${yyyy}-${mm}-${dd}`;
  return today;
};

const randomIntegerInRange = (min, max) => {
  return Math.floor(Math.random() * (max - min + 1)) + min;
};

const trace = label => x => {
  console.log(label, x);
  return x;
};

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

const parse_date = date => {
  if (!date) return 0;
  return Date.parse(date);
};

module.exports = {
  getToday,
  randomIntegerInRange,
  trace,
  generate_random_token,
  parse_date
};
