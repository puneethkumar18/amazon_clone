// ignore_for_file: use_build_context_synchronously

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateProduct({
    required Product product,
    required BuildContext context,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context);
    try {
      http.Response response = await http.post(
        Uri.parse(
          '$uri/api/rate-product',
        ),
        body: {
          'id': product.id,
          'rating': rating,
        },
        headers: {
          'Content-Type': 'applications/json; charset:UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          showSnakeBar(
            context: context,
            message: 'Thank you for rating the product !',
          );
        },
      );
    } catch (e) {
      showSnakeBar(
        context: context,
        message: e.toString(),
      );
    }
  }
}