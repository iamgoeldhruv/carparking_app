import 'package:flutter/material.dart';
class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
 const TextFieldInput({
    Key? key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
  }) : super(key: key);

  @override
Widget build(BuildContext context) {
  final inputBorder = OutlineInputBorder(
    borderSide: Divider.createBorderSide(context),
    borderRadius: BorderRadius.circular(10.0),
  );

  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15.0),
    child: TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isPass,
    ),
  );
}
}