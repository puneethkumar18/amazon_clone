const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const jwt =require("jsonwebtoken");
const auth = require("../middlewares/auth");

const authRouter = express.Router();

//Sign Up
authRouter.post("/api/signup",async(req,res) => {
    try{
        const { name,email,password } = req.body;
      

    const existingUser = await User.findOne({ email });
    if(existingUser){
        return res.status(400).json({message: "entered email already exixts"});
    }
   
    let user = new User({
        name,
        email,
        password,
    });
    user = await user.save();
    res.json(user);
    } catch(e){
        res.status(500).json({error :e.message});
    }
});

authRouter.post("/api/signin",async(req,res) => {
    console.log(req.body);
   try{
    const {email,password}  = req.body;
    const user = await User.findOne({ email });
    if(!user){
        return res
        .status(400)
        .json({message :"User with this Email does not Exists"});
    }
    const isMatch = await bcryptjs.compare(password,user.password);
    if(!isMatch){
        return res.status(400).json({ message: "Incorrect password" });
    }
    const token = jwt.sign({id:user._id},"passwordKey");
    res.json({token,...user._doc});
   }catch(e){
    res.status(500).json(e.message);
   }
})

authRouter.post("/tokenIsValid", async(req,res) => {
    try {
        const token =  req.header('x-auth-token');
        if(!token) return res.json(false);
        const verified = jwt.verify(token,'passwordKey');
        if(!verified) return res.json(false);

        const user = await User.findById(verified._id);
        if(!user) return res.json(false);
        res.json(true);
    } catch (e) {
        res.status(500).json(e.message);
    }
});

//get user data 
authRouter.get('/',auth,async(req,res) => {
    try{
        const user = await User.findById(req.user);
        res.json(...user._doc);
    }catch(e){
        return res.status(500).json({err:e.message});
    }
});


module.exports = authRouter;