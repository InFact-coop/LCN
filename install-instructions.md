### Instructions for running locally

Create a `.env` file containing:

```
AIRTABLE_API_KEY=
AIRTABLE_BASE=
AIRTABLE_BASE_DEV=
AIRTABLE_BASE_TEST=
MAILER_EMAIL_ID=
SENDGRID_API_KEY=
MAILER_SERVICE_PROVIDER=
MONGODB_URI=
MONGO_URI=
SESSION_SECRET=
```

To fill these out [check the airtable api docs](https://airtable.com/api) selecting the base you want to work with.

run the following commands:

- Install dependencies: `npm i`

- Install elm dependencies `elm package install`

- Run server tests: `npm run test`

- Run a live updating elm server (front end): `npm run dev-frontend`

- Run the backend with live updating: `npm run dev-backend`

- Build the front end: `npm run heroku-postbuild`

- Start the server: `npm start`
