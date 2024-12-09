import 'package:flutter/animation.dart';

class Product_local {
  final int id;
  final String title;
  final String description;
  final String image;
  final String review;
  final String seller;
  final double price;
  final List<Color> colors;
  final int category;
  final double rate;
  int quantity;

  Product_local(
      {required this.id,
        required this.title,
        required this.review,
        required this.description,
        required this.image,
        required this.price,
        required this.colors,
        required this.seller,
        required this.category,
        required this.rate,
        required this.quantity});
}