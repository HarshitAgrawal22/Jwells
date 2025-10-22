import "package:flutter/material.dart";

class MyTextField extends StatelessWidget {
  final double height;
  final double width;
  final String hintText;
  final Color fillColor;
  final bool obscureText;
  final TextEditingController? controller;
  const MyTextField({
    super.key,
    required this.height,
    required this.controller,
    required this.width,
    required this.hintText,
    required this.fillColor,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: height * 0.05,
        horizontal: width * 0.05,
      ),
      decoration: BoxDecoration(),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: fillColor,
          filled: true,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
