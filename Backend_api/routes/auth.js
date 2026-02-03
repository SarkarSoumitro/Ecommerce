//importing express module
const express = require("express");
//importing the User model
const User = require("../models/user");
//importing the bcrypt module for password hashing
const bcrypt = require("bcrypt");
//creating an instance of express router
const authRouter = express.Router();
//importing the jsonwebtoken module for token generation
const jst = require("jsonwebtoken");
//defining the signup route
authRouter.post("/api/signup", async (req, res) => {
  //extracting fullname, email and password from the request body
  try {
    //destructuring the request body
    const { fullname, email, password } = req.body;
    //checking if the email already exists in the database
    const existingEmail = await User.findOne({ email });
    //if email exists, send error response
    if (existingEmail) {
      //if email already exists
      return res.status(400).json({ message: "Email is already registered" });
    } else {
      //Generate a salt with cost factor of 10
      //Salt is random data that is used as an additional input to a one-way function that "hashes" a password or passphrase.
      const salt = await bcrypt.genSalt(10);
      //Hash the password using the generated salt
      const hashedPassword = await bcrypt.hash(password, salt);
      //Create a new user with the provided fullname, email, and hashed password
      let user = await new User({
        fullname,
        email,
        password: hashedPassword,
        
      }).save();
      //send success response
      return res.status(200).json({ message: "Signup is successful", user });
    }
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});


//defining the signin route
authRouter.post("/api/signin", async (req, res) => {
  //extracting email and password from the request body
  try {
    //destructuring the request body
    const { email, password } = req.body;
    //checking if the user with the provided email exists in the database
    const user = await User.findOne({ email });
    //if user does not exist, send error response
    if (!user) {
      //if user not found with the provided email
      return res
        .status(400)
        .json({ message: "User not found with this email" });
    } else {
      //compare the provided password with the stored hashed password
      const isMatch = await bcrypt.compare(password, user.password);
      //if passwords do not match, send error response
      if (!isMatch) {
        //if password does not match
        return res.status(400).json({ message: "Incorrect password" });
        //if passwords match, generate a JWT token
      } else {
        //generate a JWT token with the user's ID as payload
        const token = jst.sign({ _id: user._id }, "passwordKey");
        //remove sensitive information before sending user data
        const { password, ...userWithoutPassword } = user._doc;
        //send the responses
        res.json({ token, user: userWithoutPassword });
      }
    }
  } catch (error) {
    //handle any server errors
    return res.status(500).json({ error: error.message });
  }
});

module.exports = authRouter;
