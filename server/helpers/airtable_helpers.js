const Airtable = require('airtable');
const base = Airtable.base(process.env.AIRTABLE_BASE);

Airtable.configure({
  endpointUrl: 'https://api.airtable.com',
  apiKey: process.env.AIRTABLE_API_KEY
});

const retrieve_comment_likes = commentId => {
  return new Promise((resolve, reject) => {
    base('Qual').find(commentId, (err, record) => {
      if (err) reject(err);

      resolve(record.fields['Likes']);
    });
  });
};

const upvote_comment = (commentId, likes) => {
  return new Promise((resolve, reject) => {
    const upvotedCount = likes + 1;
    base('Qual').update(
      commentId,
      {
        Likes: upvotedCount
      },
      (err, record) => {
        if (err) return reject(err);
        resolve(record.fields['Likes']);
      }
    );
  });
};
module.exports = { retrieve_comment_likes, upvote_comment };
