import 'dart:convert';
import 'dart:typed_data';

import 'package:app_web/global_varieable.dart';
import 'package:app_web/models/banner.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;

class BannerController {
  //upload banner image to cloudinary and save to database
  uploadBanner({required Uint8List pickedImage, required context}) async {
    //upload banner image to cloudinary and get the image url
    try {
      //the bellow line has set the cloudinary api key and secret
      final cloudinary = CloudinaryPublic('dhwq9bhzl', 'sl0ojigx');
      //imageResponses is storing the response from cloudinary
      CloudinaryResponse imageResponses = await cloudinary.uploadFile(
        //the bellow line has set the folder name in cloudinary
        CloudinaryFile.fromByteData(
          //the bellow line has set the image name in cloudinary
          pickedImage.buffer.asByteData(),
          //the bellow line has set the image name in cloudinary
          identifier: 'pickedImage',
          //the bellow line has set the folder name in cloudinary
          folder: 'banners',
        ),
      );
      //secureUrl is the url of the image in cloudinary
      String image = imageResponses.secureUrl;
      BannerModel bannerModel = BannerModel(id: '', image: image);

      http.Response response = await http.post(
        Uri.parse("$uri/api/banner"),
        body: bannerModel.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      //manageHttpResponse is a function that handles the response from the server
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Banner added successfully");
        },
      );
    } catch (e) {
      print("Error uploading banner image: $e");
    }
  }

  //fetch banners
  Future<List<BannerModel>> loadBanners() async {
    try {
      //send request to the server to get the banners
      http.Response response = await http.get(
        Uri.parse("$uri/api/banner"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners = data
            .map((banner) => BannerModel.fromJson(banner))
            .toList();
        return banners;
      } else {
        throw Exception("Failed to load banners");
      }
    } catch (e) {
      throw Exception("Error loading banners $e");
    }
  }
}
