import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
class Category extends Equatable {
  final String name;
  final String imageUrl;




  const Category( {
    required this.name,
    required this.imageUrl,

  });


  @override
  List<Object?> get props => [name, imageUrl];
  static Category fromSnapshot(DocumentSnapshot snap){
    Category category =Category(name: snap['name'],
        imageUrl: snap['imageUrl'] ,);
    return category;
  }

  static List<Category> categories = [
    Category(
      name: "Men's Wear",

      imageUrl:
      'https://thriftly.ktm.yetiappcloud.com/uploads/1676788340819eAY06P8nzjrVIGFsrqX4vObluWckaSK.png',
    ),
    Category(


      name: "Women's Wear",
      imageUrl:
      'https://thriftly.ktm.yetiappcloud.com/uploads/1676789026244kj1TIp2485vQhjxA2ETUWh3RAPirGzEQ.png',

    ),
    Category(


      name: "Child's Wear",
      imageUrl:
      'https://thriftly.ktm.yetiappcloud.com/uploads/167678842559142MXL8A2EIwgEs29diDNMf2tDhq5PQpr.png',

    ),
    Category(


      name: "Other accesories",
      imageUrl:
      'https://cdn.shopify.com/s/files/1/0281/3837/3173/files/dressbarn_Rich_Media_Blog_2_Types_of_Accessories_Header_600x600.jpg?v=1629829475',

    ),
  ];
}
/*class Category extends Equatable {
  final String name;
  final String imageUrl;



  const Category( {
    required this.name,
    required this.imageUrl,
    required this.type,
  });
  @override
  List<Object?> get props => [name, imageUrl];
  static Category fromSnapshot(DocumentSnapshot snap){
    Category category =Category(name: snap['name'],
        imageUrl: snap['imageUrl'] );
 return category;
  }

  static List<Category> categories = [
    Category(
      name: "Men's Wear",

      imageUrl:
      'https://thriftly.ktm.yetiappcloud.com/uploads/1676788340819eAY06P8nzjrVIGFsrqX4vObluWckaSK.png',
    ),
    Category(


      name: "Women's Wear",
      imageUrl:
          'https://thriftly.ktm.yetiappcloud.com/uploads/1676789026244kj1TIp2485vQhjxA2ETUWh3RAPirGzEQ.png',

    ),
    Category(

      name: "Child's Wear",
      imageUrl:
          'https://thriftly.ktm.yetiappcloud.com/uploads/167678842559142MXL8A2EIwgEs29diDNMf2tDhq5PQpr.png',

    ),
    Category(

      name: "Other accesories",
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0281/3837/3173/files/dressbarn_Rich_Media_Blog_2_Types_of_Accessories_Header_600x600.jpg?v=1629829475',

    ),
  ];
}
*/