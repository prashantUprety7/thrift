import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product_api.dart';
import '../widgets/Custom_Appbar.dart';

class MessageScreen extends StatefulWidget {
  static const String routeName = '/message';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) => MessageScreen());
  }
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<MessageScreen> {
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Messages',

      ),
      body: Column(children: [
        Expanded(
          child: FutureBuilder(  future:getapi(),builder: (context,AsyncSnapshot<List<ProductApi>>snapshot){

            return ListView.builder(itemCount:productapi.length ,itemBuilder: (context,index){
               return ListTile(leading:CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index].url.toString(),)),  title: Text(snapshot.data![index].title.toString()));


            }
    );
    }
  ),
        )
      ],),

    );

  }
}