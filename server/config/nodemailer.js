const hbs = require('nodemailer-express-handlebars');
const email = process.env.MAILER_EMAIL_ID;
const pass = process.env.MAILER_EMAIL_PASSWORD;
const nodemailer = require('nodemailer');
const path = require('path');

const smtpTransport = nodemailer.createTransport({
  host: 'smtp.gmail.com',
  port: 465,
  secure: true,
  auth: {
    user: email,
    pass
  }
});

const handlebarsOptions = {
  viewEngine: 'handlebars',
  viewPath: path.resolve('./server/views/email'),
  extName: '.html'
};

smtpTransport.use('compile', hbs(handlebarsOptions));

module.exports = smtpTransport;
