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

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(title)));
  print(title);
}
