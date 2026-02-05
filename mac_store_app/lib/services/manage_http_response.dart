import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response, //the http response from the request
  required BuildContext context, // the context is to show the snackbar
  required VoidCallback
  onSuccess, //the call back to execute successfull response
}) {
  //switch status to handle different status code
  switch (response.statusCode) {
    case 200:

      ///status code 200 indicates a successful request
      onSuccess();
      break;
    case 400:
      //status code 400 indicates a bad request
      showSnackBar(context, json.decode(response.body)['message']);
      break;
    case 500:
      //status code 500 indicates a server error
      showSnackBar(context, json.decode(response.body)['error']);
      break;
    case 200:
      //status code 201 indicates resource was created successfully
      onSuccess();
      break;
  }
}

// void showSnackBar(BuildContext context, String title) {
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
//   print(title);
// }
void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.all(16),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.info_outline, color: Colors.red),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  print(title);
}
