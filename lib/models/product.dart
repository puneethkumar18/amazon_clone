import 'dart:convert';

import 'package:amazon_clone/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> imageUrls;
  final String? id;
  final List<Rating>? rating;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.imageUrls,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
    result.addAll({'category': category});
    result.addAll({'imageUrls': imageUrls});
    if (id != null) {
      result.addAll({'id': id});
    }
    if (rating != null) {
      result.addAll({'rating': rating});
    }

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toDouble() ?? 0.0,
      category: map['category'] ?? '',
      imageUrls: List<String>.from(map['imageUrls']),
      id: map['_id'],
      rating: map['ratings']
          ? List<Rating>.from(
              map['ratings']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
