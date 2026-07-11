import 'package:clothes/Models/category_model.dart';

class ProductModel {
  int? id;
  String? title;
  num? price;
  String? description;
  CategoryModel? category;
  List<String>? images;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.images,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category =
        json['category'] != null ? CategoryModel.fromJson(json['category']) : null;
    images = json['images'] != null ? List<String>.from(json['images']) : [];
  }

  // Some images returned by the API come wrapped like ["https://...\"]"]
  // this helper strips stray quotes/brackets so Image.network doesn't fail.
  String get firstImage {
    if (images == null || images!.isEmpty) {
      return 'https://placehold.co/400x400';
    }
    return images!.first.replaceAll(RegExp(r'[\[\]"]'), '');
  }
}
