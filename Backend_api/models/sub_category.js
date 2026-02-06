const mongoose = require("mongoose");
//defining the sub category schema
const subCategorySchema = mongoose.Schema({
  //defining the name field
  categoryId: {
    type: String,
    required: true,
  },
  categoryName: {
    type: String,
    required: true,
  },

  image: {
    type: String,
    required: true,
  },

  subCategoryName: {
    type: String,
    required: true,
  },
});

const subCategory = mongoose.model("SubCategory", subCategorySchema);
module.exports = subCategory;
