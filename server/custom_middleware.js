const https_redirect = (req, res, next) => {
  if (process.env.NODE_ENV === "production") {
    if (req.headers["x-forwarded-proto"] != "https") {
      return res.redirect(`https://${req.headers.host}${req.url}`);
    } else {
      return next();
    }
  } else {
    return next();
  }
};

module.exports = { https_redirect };
