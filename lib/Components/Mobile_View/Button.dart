import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double height;
  final double width;
  final Widget item;
  final Function()? onPressed;
  const MyButton({
    super.key,
    required this.height,
    required this.width,
    required this.item,
    this.onPressed,
  });

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height / 70,
        horizontal: width / 20,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height / 70),
          child: item,
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.black),
          minimumSize: MaterialStatePropertyAll(Size(width, height * 0.12)),

          foregroundColor: MaterialStatePropertyAll(Colors.white),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
        ),
      ),
    );
  }
}
