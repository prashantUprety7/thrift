import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class SubCategory extends Equatable {
  final String name;
  final String imageUrl;

  const SubCategory({
    required this.name,
    required this.imageUrl,
  });
  // ya  categoryko  list xa
  @override
  List<Object?> get props => [name, imageUrl];

  static List<SubCategory> categories = [
    SubCategory(
      name: "Men's Wear",
      imageUrl:
      'https://thriftly.ktm.yetiappcloud.com/uploads/1676788340819eAY06P8nzjrVIoGFsrqX4vObluWckaSK.png',
    ),
    SubCategory(
      name: "Women's Wear",
      imageUrl:
      'https://thriftly.ktm.yetiappcloud.com/uploads/1676789026244kj1TIp2485vQhjxA2ETUWh3RAPirGzEQ.png',
    ),

  ];
}
