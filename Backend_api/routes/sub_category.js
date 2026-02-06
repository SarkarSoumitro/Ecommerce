const express = require("express");
const SubCategory = require("../models/sub_category");
const subCategoryRouter = express.Router();

subCategoryRouter.post("/api/subcategory", async (req, res) => {
  try {
    const { categoryId, categoryName, image, subCategoryName } = req.body;

    const subCategory = new SubCategory({
      categoryId,
      categoryName,
      image,
      subCategoryName,
    });
    await subCategory.save();
    return res.status(201).send({ subCategory });
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

subCategoryRouter.get(
  "/api/category/:categoryName/subcategory",
  async (req, res) => {
    try {
      //extracting categoryName from the request parameters
      const { categoryName } = req.params;
      //finding subcategories based on the categoryName
      const subcategories = await SubCategory.find({
        categoryName: categoryName,
      });
      if (!subcategories || subcategories.length === 0) {
        return res
          .status(404)
          .json({ message: "No subcategories found for this category" });
      } else {
        return res.status(200).json(subcategories);
      }
    } catch (error) {
      return res.status(500).json({ error: error.message });
    }
  },
);

module.exports = subCategoryRouter;
