const mongoose = require("mongoose");
//defining the category schema
const categorySchema = mongoose.Schema({
  //defining the name field
  name: {
    type: String,
    required: true,
  },
  image: {
    type: String,
    required: true,
  },
  banner: {
    type: String,
    required: true,
  },
});

const Category = mongoose.model("Category", categorySchema);
module.exports = Category;
