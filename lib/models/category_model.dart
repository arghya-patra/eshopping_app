// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

categoryModel categoryModelFromJson(String str) =>
    categoryModel.fromJson(json.decode(str));

//String categoryModelToJson(categoryModel data) => json.encode(data.toJson());

class categoryModel {
  List<category> categories;

  categoryModel({
    required this.categories,
  });

  factory categoryModel.fromJson(Map<String, dynamic> json) => categoryModel(
        categories: List<category>.from(
            json["categories"].map((x) => category.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  //     };
}

class category {
  String name;
  List<String> subcategory;

  category({
    required this.name,
    required this.subcategory,
  });

  factory category.fromJson(Map<String, dynamic> json) => category(
        name: json["name"],
        subcategory: List<String>.from(json["subcategory"].map((x) => x)),
      );

  // Map<String, dynamic> toJson() => {
  //       "name": name,
  //       "subcategory": List<dynamic>.from(subcategory.map((x) => x)),
  //     };
}
