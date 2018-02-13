if (process.env.NODE_ENV !== "production" && !process.env.CI) {
  require("dotenv").config();
  if (process.env.NODE_ENV === "test") {
    process.env.AIRTABLE_BASE = process.env.AIRTABLE_BASE_TEST;
  } else if (process.env.NODE_ENV === "development") {
    process.env.AIRTABLE_BASE = process.env.AIRTABLE_BASE_DEV;
  }
}
