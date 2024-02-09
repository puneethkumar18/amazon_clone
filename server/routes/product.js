const express = require('express');
const productRouter = express.Router();
const Product = require('../models/product')
const auth = require('../middlewares/auth');

//api to get products of same category
//'/api/products?category=essentails' to access this category -> req.query.category
// '/api/products:category=essentails' to access this category -> req.params.category
productRouter.get('/api/products',auth,async(req,res)=>{
    try {
        console.log(req.query.category)
        const products = await Product.find({category:req.query.category});
        res.json(products);
        
    } catch (e) {
        res.status(500).json({ error:e.message });
    }
});

module.exports = productRouter;