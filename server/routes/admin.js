const express = require("express");
const admin = require("../middlewares/admin");
const Product = require("../models/product");

const adminRouter = express.Router();


//Add Product 
adminRouter.post('/admin/add-product',admin,async(req,res) => {
   try {
    const {name ,descripton,price,quantity,images,category} = req.body;
    let product = new Product({
        name,
        descripton,
        price,
        quantity,
        images,
        category,
    });
    product = await product.save();
    res.json(product);
   } catch (err) {
    res.status(500).json({ error:err.message })
   }
});

//Get the products from databse
adminRouter.get('/admin/get-products',admin,async(req,res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        res.status(500).json({error:e.message});
    }
});

//Delete Product from database
adminRouter.post("/admin/delete-product",admin,async(req,res) => {
    try {
        const {id} = req.body;
        const product =  await Product.findByIdAndDelete(id);
        product =  await product.save();
        res.json(product);
    } catch (e) {
        res.status(500).json({error:e.message});
    }
});

module.exports = adminRouter;