import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/pages/home/CartPage.dart';
import 'package:ecommerce/presentation/pages/home/Favorite.dart';
import 'package:ecommerce/presentation/pages/home/Notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories_main_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CategoriesMainPage(initialTab: 0),
    const Favorite(),
    const Cartpage(),
    const Notifications(),
  ];

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final items = <Widget>[
      const Icon(Icons.home_outlined, size: 30),
      const Icon(Icons.favorite_border, size: 30),
      const Icon(Icons.shopping_bag_outlined, size: 30),
      const Icon(Icons.notifications_outlined, size: 30),
    ];

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: _currentIndex,
        height: 55,
        color: appColors.search,
        buttonBackgroundColor: appColors.primary,
        backgroundColor: appColors.primary,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
