const router = require('express').Router();
const Airtable = require('airtable');
const base = Airtable.base(process.env.AIRTABLE_BASE);
const fs = require('fs');
const R = require('ramda');
const helpers = require('../helpers');

Airtable.configure({
  endpointUrl: 'https://api.airtable.com',
  apiKey: process.env.AIRTABLE_API_KEY
});

router.route('/post-comment').post((req, res) => {
  let newForm = req.body;
  newForm['Likes'] = helpers.randomIntegerInRange(0, 300);
  base('Qual').create(newForm, (err, record) => {
    if (err) {
      console.log('ERR', err);
      return res.status(500).json({ success: false });
    }
    return res.json({ success: true });
  });
});

router.route('/post-stats').post((req, res) => {
  let newForm = req.body;
  newForm['Date'] = helpers.getToday();
  let peopleSeen = 0;
  base('Quant').create(newForm, (err, record) => {
    if (err) {
      console.log('Post Stats Error', err);
      return res.status(500).json({ postSuccess: false });
    }
    base('Quant')
      .select({
        fields: ['People seen weekly'],
        filterByFormula: `AND(DATETIME_DIFF(NOW(), {Date}, 'weeks') <= 1)`
      })
      .eachPage(
        function page(records, fetchNextPage) {
          records.forEach(record => {
            peopleSeen += record.get('People seen weekly');
          });

          fetchNextPage();
        },
        function done(err) {
          if (err) {
            console.error('Get Stats Error', err);
            return res.json({ postSuccess: true, getSuccess: false });
          }
          return res.json({ postSuccess: true, getSuccess: true, peopleSeen });
        }
      );
  });
});

router.route('/get-comments').get((req, res) => {
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
          console.error('ERR', err);
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
