const express = require("express");
const Product = require("../models/product");
const productRouter = express.Router();

//get category Product
productRouter.get("/api/get-CategoryProduct", auth, async (req, res) => {
  try {
    const products = await Product.find({ category: req.query.category });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// get product based on the search
productRouter.get("/api/product/search/:name", auth, async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regx: req.params.name, $options: "i" },
    });
    res.json(products);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = productRouter;
