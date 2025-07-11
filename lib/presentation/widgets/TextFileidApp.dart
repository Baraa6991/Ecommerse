import 'package:flutter/material.dart';

class TextFileidApp extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;
  final Color borderColor;
  final Color backgroundColor;
  final Color hintColor;
  final Color iconColor;
  final Color textColor;
  final TextInputType keyboardType;

  const TextFileidApp({
    super.key,
    required this.hintText,
    required this.icon,
    this.controller,
    required this.borderColor,
    required this.backgroundColor,
    required this.hintColor,
    required this.iconColor,
    required this.textColor,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor,width: 3),
        
      ),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: textColor),
        decoration: InputDecoration(
          icon: Icon(icon, color: iconColor),
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
