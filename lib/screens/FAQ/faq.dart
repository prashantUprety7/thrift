import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thriftly/widgets/Custom_Appbar.dart';

class FAQPage extends StatelessWidget {
  static const String routeName = '/faq';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => FAQPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
        title: 'FAQ',
    ),
    body: ListView(
    children: <Widget>[
    ExpansionTile(
    initiallyExpanded: false,
    title: reuseText(
    'How can I order online?',
    ),
    children: [
    ListTile(
    title: Text('Very good product'),
    ),
    ],
    ),
      ExpansionTile(
        initiallyExpanded: false,
        title: reuseText(
          'How can I order online?',

        ),
        children: [
          ListTile(
            title: reuseText('Very good product'),
          ),
        ],
      ),
      ExpansionTile(
        initiallyExpanded: false,
        title: reuseText(
          'How can I order online?',
        ),
        children: [
          ListTile(
            title:reuseText('How can I contact peoples?'),
          ),
        ],
      ),
      ExpansionTile(
        initiallyExpanded: false,
        title: reuseText('How can I get my delivery?'),
        children: [
          ListTile(
            title: Text('Very good product'),
          ),
        ],
      ),
      ExpansionTile(
        initiallyExpanded: false,
        title:reuseText('Where is Thriftly based?'),
        children: [
          ListTile(
            title: Text('Very good product'),
          ),
        ],
      ),
    // Add more ExpansionTiles or ListTiles here
    ],
    ));

  }
}

reuseText(String title){
  return Text(title,style: TextStyle(fontFamily: 'RobotoM',fontSize: 20,));
}