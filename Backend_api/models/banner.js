const mongoose = require("mongoose");
//defining the banner schema
const bannerSchema = mongoose.Schema({
  //defining the image field
  image: {
    type: String,
    required: true,
  },
});

const Banner = mongoose.model("Banner", bannerSchema);
module.exports = Banner;
