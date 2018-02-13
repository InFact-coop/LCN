const router = require('express').Router();
const Airtable = require('airtable');
const base = Airtable.base(process.env.AIRTABLE_BASE);
const fs = require('fs');
const cloudinary = require('cloudinary');

cloudinary.config({
  cloud_name: process.env.CLOUDINARY_CLOUDNAME,
  api_key: process.env.CLOUDINARY_API_KEY,
  api_secret: process.env.CLOUDINARY_API_SECRET
});

Airtable.configure({
  endpointUrl: 'https://api.airtable.com',
  apiKey: process.env.AIRTABLE_API_KEY
});

router.route('/upload-form').post((req, res, next) => {
  console.log('req.body!', req.body);
  let newForm = req.body;
  if (newForm['Role'] === '') newForm['Role'] = 'Backend';
  if (newForm['Start Date'] === '') newForm['Start Date'] = '1970-01-01';
  if (newForm['Contract Length'] === '')
    newForm['Contract Length'] = '3 months';

  console.log('newForm!', newForm);
  base(process.env.AIRTABLE_TABLE).create(newForm, (err, record) => {
    if (err) {
      console.log('ERR', err);
      return res.json({ success: false });
    }
    console.log('SUCCESS', record);
    return res.json({ success: true });
  });
});

router.route('/video-upload').post((req, res, next) => {
  fs.rename(req.file.path, `${req.file.path}.mp4`, function(err) {
    // cloudinary documentation is wrong here, for uploader.upload the callback is the second argument and the options are the third
    // the callback also has the arguments the wrong way round with the 'result' going first and the 'err' last

    cloudinary.uploader.upload(
      `${req.file.path}.mp4`,
      function(result, err) {
        if (err) {
          console.log('err', err);
        }
        console.log('result', result);
        let response = { success: true };
        response[req.body.question] = result.secure_url;
        return res.json(response);
      },
      { resource_type: 'video' }
    );
  });
});

router.route('/audio-upload').post((req, res, next) => {
  fs.rename(req.file.path, `${req.file.path}.webm`, function(err) {
    // cloudinary documentation is wrong here, for uploader.upload the callback is the second argument and the options are the third
    // the callback also has the arguments the wrong way round with the 'result' going first and the 'err' last
    cloudinary.uploader.upload(
      `${req.file.path}.webm`,
      function(result, err) {
        if (err) {
          console.log('err', err);
        }
        console.log('result', result);
        return res.json({ success: true, q1: result.secure_url });
      },
      { resource_type: 'raw' }
    );
  });
});

module.exports = router;
