const express = require("express");
const admin = require("../middlewares/admin");
const Product = require("../models/product");

adminRouter = express.Router();

// AddProduct
adminRouter.post("/admin/addProduct", admin, async (req, res) => {
  try {
    const { name, description, price, quantity, category, imageUrls } =
      req.body;

    let product = new Product({
      name,
      description,
      price,
      quantity,
      category,
      imageUrls,
    });

    product = await product.save();
    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//delete Product
adminRouter.post("/admin/deleteProduct", admin, async (req, res) => {
  try {
    const { id } = req.body;
    let product = await Product.findByIdAndDelete(id);

    res.json(product);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = adminRouter;
