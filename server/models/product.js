const mongoose = require("mongoose");

const productSchema = mongoose.Schema({
  name: {
    type: String,
    trim: true,
    required: true,
  },
  description: {
    required: true,
    type: String,
    trim: true,
  },
  imageUrls: [
    {
      type: String,
      required: true,
    },
  ],
  price: {
    type: Number,
    required: true,
  },

  quantity: {
    type: Number,
    required: true,
  },
  category: {
    type: String,
    required: true,
  },
});

const Product = mongoose.model("Product", Product);

module.exports = Product;
