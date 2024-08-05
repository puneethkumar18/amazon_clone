// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final clodinary = CloudinaryPublic('dkjwo0f9o', 'shqkdxni');
      List<String> imageUrl = [];

      for (int i = 0; images.length > i; i++) {
        CloudinaryResponse res = await clodinary.uploadFile(
          CloudinaryFile.fromFile(
            images[i].path,
            folder: name,
          ),
        );
        imageUrl.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        imageUrls: imageUrl,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/admin/addProduct'),
        body: product.toJson(),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnakeBar(
              context: context,
              message: 'Product added Successfully!',
            );
            Navigator.pop(context);
          });
    } catch (e) {
      showSnakeBar(
        context: context,
        message: e.toString(),
      );
    }
  }

  // get all products
  Future<List<Product>> fetchAllProduct(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: {
          'Content-Type': 'applications/json; charset:UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnakeBar(
        context: context,
        message: e.toString(),
      );
    }
    return productList;
  }

  //delete product
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onDelete,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/deleteProduct'),
        body: {
          'id': product.id,
        },
        headers: {
          'Content-Type': 'applications/json; charset:UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnakeBar(
              context: context,
              message: 'Product has been deleted',
            );
            onDelete();
          });
    } catch (e) {
      showSnakeBar(
        context: context,
        message: e.toString(),
      );
    }
  }
}
