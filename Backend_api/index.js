//importing the express module
const express = require("express");
//importing the mongoose module
const mongoose = require("mongoose");
//importing the auth router
const authRouter = require("./routes/auth");
const bannerRouter = require("./routes/banner");
const categoryRouter = require("./routes/category");
const subCategoryRouter = require("./routes/sub_category");
const productRouter = require("./routes/product");
//Define the port number the server will listen on
const PORT = 3000;
//create an instance of an express application
//because it gives us starting the point for building our server
const app = express();
//database connection string
const DB =
  "mongodb+srv://soumitrosarkar78_db_user:122272sarkar@cluster0.fawclqs.mongodb.net/?appName=Cluster0";

//middleware to parse incoming request bodies in JSON format
app.use(express.json());
//middleware for authentication routes
app.use(authRouter);
//connect to the database
app.use(bannerRouter);
app.use(categoryRouter);
app.use(subCategoryRouter);
app.use(productRouter);
mongoose
  .connect(DB)
  .then(() => {
    console.log("MongoDB Connection Successful");
  })
  .catch((error) => {
    console.log("MongoDB Connection Failed:", error.message);
  });
//start the server and listen the specified port
app.listen(PORT, "0.0.0.0", function () {
  console.log(`Server is running on http://localhost:${PORT}`);
});
