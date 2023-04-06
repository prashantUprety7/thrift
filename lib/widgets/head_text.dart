import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class head_text extends StatelessWidget {
  String title;
  head_text({Key? Key, required this.title}) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline6
          )),
    );
  }
}
