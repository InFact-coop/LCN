const User = require('../models/user');
const Airtable = require('airtable');
const base = Airtable.base(process.env.AIRTABLE_BASE);
const fs = require('fs');
const R = require('ramda');
const helpers = require('../helpers');
const {
  retrieve_comment_likes,
  upvote_comment
} = require('../helpers/airtable_helpers');
const {
  update_user_comments_liked,
  check_user_commented
} = require('../helpers/db_helpers');

Airtable.configure({
  endpointUrl: 'https://api.airtable.com',
  apiKey: process.env.AIRTABLE_API_KEY
});

const post_comment = (req, res) => {
  let newForm = req.body;
  newForm['Likes'] = 0;
  base('Qual').create(newForm, (err, record) => {
    if (err) {
      console.log('ERR', err);
      return res.status(500).json({ success: false });
    }
    return res.json({ success: true });
  });
};

const post_upvote = async (req, res) => {
  const commentId = req.body.comment_id;
  try {
    const likes = await retrieve_comment_likes(commentId);
    const likesUpVoted = await upvote_comment(commentId, likes);
    const updateUser = await update_user_comments_liked(req.user, commentId);
    return res.json({
      success: true,
      commentId: commentId,
      commentLikes: likesUpVoted
    });
  } catch (err) {
    console.log('Error upvoting comment: ', err);
    return res.status(500).json({ success: false });
  }
};

const post_user_details = (req, res) => {
  const { law_centre, job_role, law_area, ...body } = req.body;
  User.findByIdAndUpdate(
    { _id: req.user._id },
    {
      law_centre,
      job_role,
      law_area
    },
    { new: true }
  )
    .exec()
    .then(updatedUser => {
      console.log('Updated User Successful', updatedUser);
      return res.json({ success: true });
    })
    .catch(err => {
      console.log(('Updated User Error', err));
      return res.json({ success: false });
    });
};

const get_user_details = (req, res) => {
  User.findById(req.user.id)
    .exec()
    .then(user => {
      return res.json({
        full_name: user.full_name,
        law_centre: user.law_centre,
        law_area: user.law_area,
        job_role: user.job_role,
        admin: user.admin
      });
    })
    .catch(err => {
      console.log('Error retrieving user: ', err);
      return res.status(500).send({ success: false });
    });
};

const post_stats = (req, res) => {
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
            if (!record._rawJson.fields['People seen weekly']) return;
            peopleSeen += record._rawJson.fields['People seen weekly'];
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
};

const get_comments = (req, res) => {
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
      async function done(err) {
        if (err) {
          console.error('ERR', err);
          return res.status(500).json({ success: false });
        }
        const dateStringToNumber = str => new Date(str).getTime();
        const createdTimeLens = R.lensProp('createdTime');
        const datedComments = comments.map(
          R.over(createdTimeLens, dateStringToNumber)
        );
        try {
          const likedComments = await check_user_commented(req.user);
          likedComments;
          const commentResponse = datedComments.map(comment => {
            comment.fields.likedByUser = likedComments.some(
              commentLiked => commentLiked === comment.id
            );
            return comment;
          });
          res.json(commentResponse);
        } catch (e) {
          console.log(e);
          return res.status(500).json({ success: false });
        }
      }
    );
};

module.exports = {
  post_comment,
  post_upvote,
  post_user_details,
  get_user_details,
  post_stats,
  get_comments
};
