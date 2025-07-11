import 'package:ecommerce/presentation/pages/home/CategoriePage.dart';
import 'package:ecommerce/presentation/pages/home/productsPage.dart';
import 'package:ecommerce/presentation/pages/home/storesPage.dart';
import 'package:flutter/material.dart';



class CategoriesMainPage extends StatefulWidget {
  final int initialTab;
  
  const CategoriesMainPage({super.key, required this.initialTab});
  
  @override
  State<CategoriesMainPage> createState() => _CategoriesMainPageState();
}

class _CategoriesMainPageState extends State<CategoriesMainPage> {
  late int _selectedTab;

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _selectedTab,
      children: [
        CategoriesPage(
          onTabChanged: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
          currentTab: _selectedTab,
        ),
        ProductsPage(
          onTabChanged: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
          currentTab: _selectedTab,
        ),
        StoresPage(
          onTabChanged: (index) {
            setState(() {
              _selectedTab = index;
            });
          },
          currentTab: _selectedTab,
        ),
      ],
    );
  }
}