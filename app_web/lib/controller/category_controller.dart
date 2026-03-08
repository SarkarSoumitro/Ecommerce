import 'dart:convert';
import 'dart:typed_data';
import 'package:app_web/global_varieable.dart';
import 'package:app_web/models/category.dart';
import 'package:app_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory({
    required Uint8List pickedImage,
    required Uint8List pickedBanner,
    required String Name,
    required BuildContext context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dhwq9bhzl', 'sl0ojigx');

      // Convert Uint8List → ByteData (required by fromByteData)
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromByteData(
          pickedImage.buffer.asByteData(),
          identifier: 'pickedImage',
          folder: 'categoryImage',
        ),
      );

      print('Image uploaded: ${imageResponse.secureUrl}');
      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromByteData(
          pickedBanner.buffer.asByteData(),
          identifier: 'pickedBanner',
          folder: 'categoryImage',
        ),
      );

      print('Banner uploaded: ${bannerResponse.secureUrl}');
      String banner = bannerResponse.secureUrl;

      Category category = Category(
        id: '',
        name: Name,
        image: image,
        banner: banner,
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/category"),
        body: category.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      // ✅ Check if the widget is still alive before using context
      if (!context.mounted) return;

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Category added successfully");
        },
      );
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  //load the updloaded category

  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/category"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Category> categories = data
            .map((category) => Category.fromJson(category))
            .toList();
        return categories;
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error loading categories $e");
    }
  }
}
