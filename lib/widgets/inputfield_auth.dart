import 'package:flutter/material.dart';
class InputTextFieldWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPassword;

  InputTextFieldWidget(this.textEditingController, this.hintText, this.isPassword);

  @override
  _InputTextFieldWidgetState createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: TextField(
        controller: widget.textEditingController,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
          ),
          fillColor: Colors.white54,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.only(bottom: 15),
          focusColor: Colors.white60,

          suffixIcon:
          widget.isPassword ? GestureDetector(
            onTap: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
            ),
          ) : null,
        ),
        obscureText: _isObscured && widget.isPassword,
        obscuringCharacter: '*',
      ),
    );
  }
}
