const jwt = require("jsonwebtoken");
const User = require("../models/user");

const admin = async (req, res, next) => {
  try {
    const token = req.headers("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "no auth token Access denied" });

    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res.status(401).json({
        msg: "authentication Token verifivation failed access denied!!",
      });
    const user = await User.findById(verified.id);

    if (user.type != "admin")
      return res.status(401).json({ msg: "Your Not An Admin !" });
    req.user = verified.id;
    req.token = token;

    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = admin;
