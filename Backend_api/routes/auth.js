const express = require("express");
const User = require("../models/user");
const bcrypt = require("bcrypt");

const authRouter = express.Router();
const jst = require("jsonwebtoken");

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { fullname, email, password } = req.body;
    const existingEmail = await User.findOne({ email });
    if (existingEmail) {
      return res.status(400).json({ message: "Email is already registered" });
    } else {
      //Generate a salt with cost factor of 10
      const salt = await bcrypt.genSalt(10);
      //Hash the password using the generated salt
      const hashedPassword = await bcrypt.hash(password, salt);

      let user = await new User({
        fullname,
        email,
        password: hashedPassword,
      }).save();
      return res.status(200).json({ message: "Signup is successful", user });
    }
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res
        .status(400)
        .json({ message: "User not found with this email" });
    } else {
      const isMatch = await bcrypt.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ message: "Incorrect password" });
      } else {
        const token = jst.sign({ _id: user._id }, "passwordKey");
        //remove sensitive information before sending user data
        const { password, ...userWithoutPassword } = user._doc;
        //send the responses
        res.json({ token, user: userWithoutPassword });
      }
    }
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

module.exports = authRouter;
