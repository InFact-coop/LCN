const smtpTransport = require('../config/nodemailer');

const send_invite_email = ({ user, token }) => {
  const data = {
    to: user.email,
    from: process.env.MAILER_EMAIL_ID,
    template: 'sign-up-email',
    subject: "You've signed up",
    context: {
      name: user.full_name.split(' ')[0]
    }
  };

  smtpTransport.sendMail(data);
};

module.exports = { send_invite_email };
