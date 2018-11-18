const Airtable = require("airtable");
const R = require("ramda");

const base = Airtable.base(process.env.AIRTABLE_BASE);

Airtable.configure({
  endpointUrl: "https://api.airtable.com",
  apiKey: process.env.AIRTABLE_API_KEY
});

const retrieve_comment_likes = commentId => {
  return new Promise((resolve, reject) => {
    base("Qual").find(commentId, (err, record) => {
      if (err) reject(err);

      resolve(record.fields["Likes"]);
    });
  });
};

const upvote_comment = (commentId, likes) => {
  return new Promise((resolve, reject) => {
    const upvotedCount = likes + 1;
    base("Qual").update(
      commentId,
      {
        Likes: upvotedCount
      },
      (err, record) => {
        if (err) return reject(err);
        resolve(record.fields["Likes"]);
      }
    );
  });
};

// Stats Response Helpers

const return_if = (requiredRole, value) => roles =>
  (R.contains(requiredRole, roles) && value) || null;

const get_all_records = new Promise((resolve, reject) => {
  let allRecords = [];
  base("Quant")
    .select({
      fields: [
        "Client matters weekly",
        "Enquiries weekly",
        "Media coverage weekly",
        "Lawyer volunteers weekly",
        "Student volunteers weekly",
        "Job roles",
        "Law area"
      ],
      filterByFormula: `AND(DATETIME_DIFF(NOW(), {Date}, 'weeks') <= 1)`
    })
    .eachPage(
      (records, fetchNextPage) => {
        allRecords = R.concat(records, allRecords);
        return fetchNextPage();
      },
      err => {
        if (err) {
          console.error("Get Stats Error", err);
          reject({ postSuccess: true, getSuccess: false });
        }
        resolve(allRecords);
      }
    );
});

const prune_records = (roles, lawArea) =>
  R.map(record => {
    const data = record._rawJson.fields;
    return {
      clientMatters: return_if("Case Worker", data["Client matters weekly"])(
        roles
      ),
      clientMattersByArea:
        (data["Law area"] === lawArea &&
          return_if("Case Worker", data["Client matters weekly"])(roles)) ||
        null,
      enquiries: return_if("Triage", data["Enquiries weekly"])(roles),
      vacancies: return_if("Management", data["Vacancies weekly"])(roles),
      mediaCoverage: return_if("Management", data["Media coverage weekly"])(
        roles
      ),
      lawyerVolunteers: return_if(
        "Management",
        data["Lawyer volunteers weekly"]
      )(roles),
      studentVolunteers: return_if(
        "Management",
        data["Student volunteers weekly"]
      )(roles)
    };
  });

const aggregate_records = records => {
  const responseObject = {
    clientMatters: null,
    clientMattersByArea: null,
    enquiries: null,
    vacancies: null,
    mediaCoverage: null,
    lawyerVolunteers: null,
    studentVolunteers: null
  };

  const return_agg_value = (aggValue, value) => {
    if (Number.isInteger(value) && Number.isInteger(aggValue)) {
      return value + aggValue;
    }

    if (R.isNil(value) && Number.isInteger(aggValue)) {
      return aggValue;
    }

    if (Number.isInteger(value) && R.isNil(aggValue)) {
      return value;
    }

    if (R.isNil(value) && R.isNil(aggValue)) {
      return null;
    }
  };

  return R.pipe(
    R.reduce(R.mergeWith(return_agg_value), responseObject),
    R.reject(R.isNil)
  )(records);
};

module.exports = {
  retrieve_comment_likes,
  upvote_comment,
  get_all_records,
  prune_records,
  aggregate_records,
  return_if
};
