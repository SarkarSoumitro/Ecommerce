const express = require("express");
const Category = require("../models/category");
const categoryRouter = express.Router();

categoryRouter.post("/api/category", async (req, res) => {
  try {
    const { name, image, banner } = req.body;
    const category = new Category({ name, image, banner });
    await category.save();
    return res.status(201).send({ category });
  } catch (error) {
    return res.status(400).send({ error: error.message });
  }
});

categoryRouter.get("/api/category", async (req, res) => {
  try {
    const categories = await Category.find();
    res.status(200).json({ categories });
  } catch (error) {
    return res.status(500).send({ error: error.message });
  }
});

module.exports = categoryRouter;
