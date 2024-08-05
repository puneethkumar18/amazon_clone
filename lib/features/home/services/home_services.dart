// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  Future<List<Product>> getCategoryProduct({
    required BuildContext context,
    required String category,
  }) async {
    List<Product> categoryProducts = [];
    final userProvider = Provider.of<UserProvider>(context);
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/get-CategoryProduct?category=$category'),
        headers: {
          'Content-Type': 'applications/json; charset:UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            categoryProducts.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnakeBar(
        context: context,
        message: e.toString(),
      );
    }
    return categoryProducts;
  }

  Future<Product> fetchDealOfTheDay(BuildContext context) async {
    Product product = Product(
      name: '',
      description: '',
      price: 0.0,
      quantity: 0.0,
      category: '',
      imageUrls: [],
    );
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse("$uri/api/deal-of-day"),
        headers: {
          'Content-Type': 'applications/json; charset:UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      showSnakeBar(context: context, message: e.toString());
    }
    return product;
  }
}
