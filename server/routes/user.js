const express = require("express");
const auth = require("../middlewares/auth");
const { Product } = require("../models/product");
const User = require("../models/user");
const Order = require("../models/order");

const userRouter = express.Router();

// add to cart
userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(user.id);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isFoundProduct = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isFoundProduct = true;
        }
      }
    }
    if (isFoundProduct) {
      let producttt = user.cart.find((productt) =>
        productt.product._id.equals(product._id)
      );
      producttt.quantity += 1;
    } else {
      user.cart.push({ product, quantity: 1 });
    }
    user = await user.save();
    res.json(user);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

//remove from cart
userRouter.delete("api/remove-from-cart/:id", auth, async (req, res) => {
  try {
    const { id } = req.params.id;
    const product = await Product.findById({ id });
    let user = await User.findById(req.user);
    for (let i = 0; i < user.cart.length; i++) {
      if (user.cart[i].product._id.equals(id)) {
        if (user.cart[i].quantity > 1) {
          user.cart[i].quantity -= 1;
        } else {
          user.cart.splice(i, 1);
        }
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(401).json({ error: e.message });
  }
});

// save user address
userRouter.post("/api/save-user-address", auth, async (req, res) => {
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// ordering Product
userRouter.post("/api/order", auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    let products = [];

    for (let i = 0; i < cart.length; i++) {
      let product = await Product.findById(cart[i].product.id);
      if (product.quantity >= cart[i].quantity) {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();
      } else {
        res.status(400).json({ msg: `${product.name} is out of Stock` });
      }
    }

    let user = await User.findById(req.user);
    user.cart = [];

    user = await user.save();
    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      oredrAt: new Date().getTime(),
    });

    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// get my Orders
userRouter.post("/api/myOrders", auth, async (req, res) => {
  try {
    const Orders = await Orders.findById({ userId: req.user });
    res.json(Orders);
  } catch (error) {
    res.status(500).json({ error: e.message });
  }
});

module.exports = userRouter;
