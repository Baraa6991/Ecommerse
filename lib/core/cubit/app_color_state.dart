import 'package:flutter/material.dart';

class ThemeState {
  final bool isDarkMode;
  final Color primary;
  final Color pageBackground;
  final Color text;
  final Color suptext;
  final Color search;
  ThemeState({
    required this.isDarkMode,
    required this.primary,
    required this.pageBackground,
    required this.text,
    required this.suptext,
    required this.search,
  });
  factory ThemeState.light() {
    return ThemeState(
      isDarkMode: false,
      primary: const Color(0xFFFF941B),
      pageBackground: const Color(0xFFFFFFFF),
      text: const Color(0xFF000000),
      suptext: const Color(0xFF555555),
      search: const Color(0xFFF7F8FB),
    );
  }
  factory ThemeState.dark() {
    return ThemeState(
      isDarkMode: true,
      primary: const Color(0xFFFF941B),
      pageBackground: const Color(0xff000000),
      text: const Color(0xffFFFFFF),
      suptext: const Color(0xff555555),
      search: const Color(0xffF7F8FB),
    );
  }
}
