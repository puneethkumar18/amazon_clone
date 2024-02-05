
import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}){
  debugPrint(response.statusCode.toString());
  switch(response.statusCode){
    case 200:
    onSuccess();
    break;
    case 400:
    showSnackBar(context, jsonDecode(response.body)['message']);
    break;
    case 500:
    showSnackBar(context, jsonDecode(response.body)['error']);
    default:
    showSnackBar(context, jsonDecode(response.body));
    break;

  }
  
}