const hbs = require('nodemailer-express-handlebars');
const email = process.env.MAILER_EMAIL_ID;
const pass = process.env.MAILER_EMAIL_PASSWORD;
const nodemailer = require('nodemailer');

const smtpTransport = nodemailer.createTransport({
  service: process.env.MAILER_SERVICE_PROVIDER,
  auth: {
    user: email,
    pass
  }
});

const handlebarsOptions = {
  viewEngine: 'handlebars',
  viewPath: path.resolve('../views/email'),
  extName: '.html'
};

smtpTransport.use('compile', hbs(handlebarsOptions));
