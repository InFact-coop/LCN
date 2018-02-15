const router = require('express').Router();
const Airtable = require('airtable');
const base = Airtable.base(process.env.AIRTABLE_BASE);
const fs = require('fs');
const R = require('ramda');

Airtable.configure({
  endpointUrl: 'https://api.airtable.com',
  apiKey: process.env.AIRTABLE_API_KEY
});

router.route('/post-comment').post((req, res, next) => {
  let newForm = req.body;
  base('Qual').create(newForm, (err, record) => {
    if (err) {
      console.log('ERR', err);
      return res.status(500).json({ success: false });
    }
    console.log('SUCCESS', record);
    return res.json({ success: true });
  });
});

router.route('/get-comments').get((req, res, next) => {
  let comments = [];
  base('Qual')
    .select()
    .eachPage(
      function page(records, fetchNextPage) {
        records.forEach(function(record) {
          comments.push(record._rawJson);
        });

        fetchNextPage();
      },
      function done(err) {
        if (err) {
          console.error(err);
          return res.status(500).json({ success: false });
        }
        const dateStringToNumber = str => new Date(str).getTime();
        const createdTimeLens = R.lensProp('createdTime');
        const commentsWithNumericalDate = comments.map(
          R.over(createdTimeLens, dateStringToNumber)
        );
        return res.json(commentsWithNumericalDate);
      }
    );
});

module.exports = router;
