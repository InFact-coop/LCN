const router = require("express").Router();

const {
  post_comment,
  post_upvote,
  post_user_details,
  get_user_details,
  post_stats,
  get_comments
} = require("../controllers/api.js");

router.route("/post-comment").post(post_comment);
router.route("/upvote").post(post_upvote);
router
  .route("/user-details")
  .post(post_user_details)
  .get(get_user_details);

router.route("/post-stats").post(post_stats);
router.route("/get-comments").get(get_comments);

module.exports = router;
