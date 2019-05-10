const hbs = require("nodemailer-express-handlebars");
const nodemailerSendgrid = require("nodemailer-sendgrid");
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
