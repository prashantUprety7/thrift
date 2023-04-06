
import 'dart:convert';

import 'package:http/http.dart' as http;

List<ProductApi> productapi = [];
Future<List<ProductApi>> getapi() async{
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  var data = jsonDecode(response.body.toString());

  if(response.statusCode ==200){
    for(Map i in data){
   ProductApi productapicall = ProductApi(title:i['title'], url: i['url']);
   productapi.add(productapicall);
    }
    return productapi;
  }else{
    return productapi;

  }
}
class ProductApi{
  String title,url;
  ProductApi({required this.title,required this.url});

}