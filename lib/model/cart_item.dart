import 'package:hive/hive.dart';

part 'cart_item.g.dart';
@HiveType(typeId: 1)
class CartItem extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  double price;
  @HiveField(3)
  String description;
  @HiveField(4)
  String category;
  @HiveField(5)
  String image;
  @HiveField(6)
  double rating;
  @HiveField(7)
  int quantity;

  CartItem(
      {required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.quantity,
        required this.rating});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      quantity:json['quantity'],
      rating: json['rating'],
    );
  }
}