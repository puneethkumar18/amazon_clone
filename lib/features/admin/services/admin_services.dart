import 'dart:io';

import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

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
    } catch (e) {
      showSnakeBar(context: context, message: e.toString());
    }
  }
}
