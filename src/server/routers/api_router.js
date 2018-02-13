const router = require("express").Router();
const Airtable = require("airtable");
const base = Airtable.base(process.env.AIRTABLE_BASE);
const fs = require("fs");

Airtable.configure({
  endpointUrl: "https://api.airtable.com",
  apiKey: process.env.AIRTABLE_API_KEY
});

router.route("/upload-form").post((req, res, next) => {
  let newForm = req.body;
  base(process.env.AIRTABLE_TABLE).create(newForm, (err, record) => {
    if (err) {
      console.log("ERR", err);
      return res.json({ success: false });
    }
    console.log("SUCCESS", record);
    return res.json({ success: true });
  });
});

module.exports = router;
