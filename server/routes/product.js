const express = require("express");
const { Product } = require("../models/product");
const productRouter = express.Router();
const auth = require("../middlewares/auth");

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

//rate the product
productRouter.post("/api/rate-product", auth, async (req, res) => {
  try {
    const { id, rating } = req.body;
    let product = await Product.findById({ id });
    for (let i = 0; i < product.ratings.length; i++) {
      if (product.ratings[i].userId == req.user) {
        product.ratings.slice(i, 1);
        break;
      }
    }
    const ratingSchema = {
      userId: req.id,
      rating,
    };

    product.ratings.push(ratingSchema);

    product = await product.save();
    res.json(product);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

//get the deal of the day
productRouter.get("/api/deal-of-day", auth, async (req, res) => {
  try {
    let products = await Product.find({});
    products.sort((a, b) => {
      aSum = 0;
      bSum = 0;
      for (let i = 0; i < a.ratings.length; i++) {
        aSum += a.ratings[i].rating;
      }
      for (let i = 0; i < b.ratings.length; i++) {
        bSum += b.ratings[i].rating;
      }
      return a < b ? 1 : -1;
    });
    res.json(products[0]);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = productRouter;
