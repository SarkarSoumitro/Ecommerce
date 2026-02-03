//models/user.js
const mongoose = require("mongoose");
//defining the user schema
const userSchema = mongoose.Schema({
  //defining the fullname field
  fullname: {
    type: String,
    required: true,
    trim: true,
  },
  //defining the email field with validation
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        const result =
          /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|.(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return result.test(value);
      },
      message: "please enter a valid email address",
    },
  },
  //defining the state, city, and locality fields
  state: {
    type: String,
    default: "",
  },
  city: {
    type: String,
    default: "",
  },
  locality: {
    type: String,
    default: "",
  },
  //defining the password field with validation
  password: {
    type: String,
    required: true,
    validate: {
      validator: (value) => {
        // Check: at least 8 chars, 1 letter, 1 number, 1 special char
        const hasMinLength = value.length >= 8;
        const hasLetter = /[A-Za-z]/.test(value);
        const hasNumber = /\d/.test(value);
        const hasSpecialChar = /[!@#$%^&*.\-_]/.test(value);
        return hasMinLength && hasLetter && hasNumber && hasSpecialChar;
      },
      message:
        "Password must be minimum eight characters, at least one letter, one number and one special character",
    },
  },
});
//creating and exporting the User model
const User = mongoose.model("users", userSchema);
module.exports = User;
