const smtpTransport = require('../config/nodemailer');

const send_invite_email = ({ user, token }) => {
  const data = {
    to: user.email,
    from: process.env.MAILER_EMAIL_ID,
    template: 'sign-up-email',
    subject: 'Invitation to LCN Feedback App',
    context: {
      name: user.full_name.split(' ')[0],
      url: `http://localhost:4000/signup?token=${user.signup_token}`
    }
  };

  smtpTransport.sendMail(data);
};

module.exports = { send_invite_email };
