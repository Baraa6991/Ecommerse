import 'package:flutter/material.dart';

class OnBordingContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget widget;
  final Function()? onTap;

  const OnBordingContainer({
    super.key,
    required this.width,
    required this.height,
    required this.color,
    required this.widget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: widget,
      ),
    );
  }
}
