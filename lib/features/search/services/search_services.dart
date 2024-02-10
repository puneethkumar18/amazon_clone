// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variable.dart';

class Searchservices {
  Future<List<Product>> fetchProductOnSearch({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: {
          'Content_Type': 'application/json; charset= UTF-8',
          'x-auth-token': user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body); i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body[i]),
                ),
              ),
            );
          }
        },
      );
      
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
