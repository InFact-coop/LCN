const smtpTransport = require("../config/nodemailer");

const send_invite_email = ({ user, token }) => {
  const data = {
    to: user.email,
    from: process.env.MAILER_EMAIL_ID,
    template: "sign-up-email",
    subject: "Invitation to LCN Feedback App - to be actioned within a week",
    context: {
      name: user.full_name.split(" ")[0],
      url: `https://lawcentres.herokuapp.com/signup?token=${user.signup_token}`
    }
  };

  smtpTransport.sendMail(data);
};

const send_signup_confirmation_email = ({ email, full_name }) => {
  const data = {
    to: email,
    from: process.env.MAILER_EMAIL_ID,
    template: "signup-confirmation-email",
    subject: "Thanks for signing up!",
    context: {
      name: full_name.split(" ")[0]
    }
  };

  smtpTransport.sendMail(data);
};

module.exports = { send_invite_email, send_signup_confirmation_email };
