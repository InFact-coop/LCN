const router = require('express').Router();
const Airtable = require('airtable');
const base = Airtable.base(process.env.AIRTABLE_BASE);
const fs = require('fs');

Airtable.configure({
  endpointUrl: 'https://api.airtable.com',
  apiKey: process.env.AIRTABLE_API_KEY
});

const getToday = () => {
  let today = new Date();
  let dd = today.getDate();
  let mm = today.getMonth() + 1; //January is 0!

  let yyyy = today.getFullYear();
  if (dd < 10) {
    dd = `0${dd}`;
  }
  if (mm < 10) {
    mm = `0${mm}`;
  }
  today = `${yyyy}-${mm}-${dd}`;
  return today;
};

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

router.route('/post-stats').post((req, res, next) => {
  let newForm = req.body;
  newForm['Date'] = getToday();
  let peopleSeen = 0;
  console.log('STATS: ', newForm);
  base('Quant').create(newForm, (err, record) => {
    if (err) {
      console.log('Post Stats Error', err);
      return res.status(500).json({ postSuccess: false });
    }
    console.log('POST SUCCESS', record);
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
            return res
              .status(500)
              .json({ postSuccess: true, getSuccess: false });
          }
          console.log('Get Stats Success', peopleSeen);
          return res.json({ postSuccess: true, getSuccess: true, peopleSeen });
        }
      );
  });
});

module.exports = router;
