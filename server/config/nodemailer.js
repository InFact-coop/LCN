const hbs = require("nodemailer-express-handlebars");
const nodemailerSendgrid = require("nodemailer-sendgrid");
const email = process.env.MAILER_EMAIL_ID;
const pass = process.env.MAILER_EMAIL_PASSWORD;
const nodemailer = require("nodemailer");
const path = require("path");

const smtpTransport = nodemailer.createTransport(
  nodemailerSendgrid({
    apiKey: process.env.SENDGRID_API_KEY
  })
);

const handlebarsOptions = {
  viewEngine: "handlebars",
  viewPath: path.resolve("./server/views/email"),
  extName: ".hbs"
};

smtpTransport.use("compile", hbs(handlebarsOptions));

module.exports = smtpTransport;
