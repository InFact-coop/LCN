### Instructions for running locally

Create a `.env` file containing:

```
AIRTABLE_API_KEY=
AIRTABLE_BASE=
AIRTABLE_BASE_DEV=
AIRTABLE_BASE_TEST=
AIRTABLE_TABLE=
```

To fill these out [check the airtable api docs](https://airtable.com/api) selecting the base you want to work with.

run the following commands:

* Install dependencies: `npm i`

* Run server tests: `npm run test`

* Run a live updating elm server (front end): `npm run dev`

* Run the backend with live updating: `npm run dev:server`

* Build the front end: `npm run build`

* Start the server: `npm start`
