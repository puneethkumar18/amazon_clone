const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcrypt");

const authRouter = express.Router();

authRouter.post("/api/signUp", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({
        msg: "User Already exists With this Email !! \n try with another email",
      });
    }

    const hasedPassword = await bcrypt.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hasedPassword,
    });

    user = await user.save();
    res.json(user);
  } catch (e) {
    return res.status(500).json({ error: e.message });
  }
});

module.exports = { authRouter, name: "puneeth" };
