require("../config.js");
const path = require("path");
const exphbs = require("express-handlebars");
const express = require("express");

// Express Middleware
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const passport = require("passport");
const flash = require("connect-flash");
const session = require("express-session");
const morgan = require("morgan");

// Custom Stuff
const api_router = require("./routers/api");
const auth_router = require("./routers/auth");
const admin_router = require("./routers/admin");

const { https_redirect } = require("./custom_middleware");

const configDB = require("./config/database");
const passportInit = require("./config/passport");
const helpers = require("./helpers.js");

const app = express();

mongoose.connect(configDB.url);
passportInit(passport);

app.use(https_redirect);
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

const hbs = exphbs.create({
  extname: "hbs",
  layoutsDir: path.join(__dirname, "views", "layouts"),
  partialsDir: path.join(__dirname, "views", "partials"),
  defaultLayout: "main",
  helpers: {
    setVariable: function(name, value) {
      this[name] = value;
    }
  }
});

app.set("views", path.join(__dirname, "views"));
app.engine("hbs", hbs.engine);
app.set("view engine", "hbs");

app.use(
  session({
    secret: process.env.SESSION_SECRET,
    resave: false,
    saveUninitialized: false
  })
);
app.use(passport.initialize());
app.use(passport.session());
app.use(flash());

app.use(morgan("dev"));

// Our Routers
app.use("/api/v1/", api_router);
app.use(express.static(path.join(__dirname, "../public")));
auth_router(app, passport);
admin_router(app);

module.exports = app;
