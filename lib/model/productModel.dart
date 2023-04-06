import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';



class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;
  final String? description;
  final String? type;
  final  Rating rating;


  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,//not present in mockapi
    required this.isPopular,//not present in mockapi
    this.description,
    this.type,
    required this.rating
  });

  static Product fromJson(dynamic json) {
    return Product(
      name: json['title'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      isRecommended: json['isRecommended'] ?? false,
      isPopular: json['isPopular'] ?? false,
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      rating: Rating.fromJson(json['rating']),
    );
  }

  @override
  List<Object?> get props => [
    name,
    category,
    imageUrl,
    price,
    isRecommended,
    isPopular,
    description,
    type,
   // rating
  ];

  }

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'].toDouble(), // convert rate to double
      count: json['count'],
    );
  }
}


/*
class Product extends Equatable {
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;
  final String? description;
  final String? type;

  const Product({
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
    this.description,
    this.type,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>?;
    if (data == null) {
      throw Exception('DocumentSnapshot data is null!');
    }

    return Product(
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      isRecommended: data['isRecommended'] ?? false,
      isPopular: data['isPopular'] ?? false,
      description: data['description'] ?? '',
      type: data['type'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    name,
    category,
    imageUrl,
    price,
    isRecommended,
    isPopular,
    description,
    type,
  ];

  static List<Product> products = [
    Product(
      name: 'names og asj',
      imageUrl:
      'https://thriftly.ktm.yetiappcloud.com/uploads/1676988288048a7hGabrhUQ4IxSs4rbvcVqRdKsOK1NOu.png',
      category: 'Mens Wear',
      price: 1500,
      isPopular: true,
      isRecommended: true,
      description: 'very good',
      type: 'clothes',
    ),
    Product(
      name: "Men's Wear",
      imageUrl:
      'https://thriftly.ktm.yetiappcloud.com/uploads/1676988288048a7hGabrhUQ4IxSs4rbvcVqRdKsOK1NOu.png',
      category: "Men's Wear",
      price: 1500,
      isPopular: true,
      isRecommended: true,
      description: 'very good',
      type: 'clothes',
    ),
    Product(
      name: "White shirt",
      imageUrl:
      'https://thriftly.ktm.yetiappcloud.com/uploads/1676969155599C5TnTrRwmqJALIixIU7qYwsOQ5je5OPG.png',
      category: "Men's Wear",
      price: 1500,
      isPopular: false,
      isRecommended: true,
      description: 'very good',
      type: 'shoes',
    ),
  ];
}
*/