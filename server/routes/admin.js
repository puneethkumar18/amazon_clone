const express = require("express");
const admin = require("../middlewares/admin");
const { Product } = require("../models/product");
const Order = require("../models/order");

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

//get orders

adminRouter.get("/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    res.json(orders);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// change order status
adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById({ id });
    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get admin analytics
adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalPrice = 0;
    for (let i = 0; i < orders.length; i++) {
      for (let j = 0; j < orders[i].products.length; i++) {
        totalPrice +=
          orders[i].products[j].product.price * orders[i].products[j].quantity;
      }
    }
    // get Earnings categoryWise
    let mobileEarnings = await fetchCategoryWiseProduct("Mobiles");
    let essentialsEarnings = await fetchCategoryWiseProduct("Essentials");
    let booksEarnings = await fetchCategoryWiseProduct("Books");
    let fashionEarnings = await fetchCategoryWiseProduct("Fashion");

    let earnings = {
      totalEarnings: totalPrice,
      mobileEarnings,
      essentialsEarnings,
      booksEarnings,
      fashionEarnings,
    };
    res.json(earnings);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseProduct(category) {
  let earnings = 0;
  let categoryOredrs = await Order.find({
    "products.product.category": category,
  });
  for (let i = 0; i < categoryOredrs.length; i++) {
    for (let j = 0; j < categoryOredrs[i].products.length; i++) {
      earnings +=
        categoryOredrs[i].products[j].product.price *
        categoryOredrs[i].products[j].quantity;
    }
  }
  return earnings;
}
module.exports = adminRouter;
