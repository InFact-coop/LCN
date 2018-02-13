const router = require('express').Router();
const Airtable = require('airtable');
// const base = Airtable.base(process.env.AIRTABLE_BASE || '0.0.0.0');
const fs = require('fs');

Airtable.configure({
  endpointUrl: 'https://api.airtable.com',
  apiKey: process.env.AIRTABLE_API_KEY || '1234'
});

router.route('/upload-form').post((req, res, next) => {
  let newForm = req.body;
  base(process.env.AIRTABLE_TABLE || 'table').create(newForm, (err, record) => {
    if (err) {
      console.log('ERR', err);
      return res.json({ success: false });
    }
    console.log('SUCCESS', record);
    return res.json({ success: true });
  });
});

module.exports = router;
