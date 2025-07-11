import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/auth/Profile/profile_cubit.dart';
import 'package:ecommerce/presentation/cubits/home/Products/products_cubit.dart';
import 'package:ecommerce/presentation/pages/auth/profile.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/gridViewProductsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  final Function(int) onTabChanged;
  final int currentTab;

  const ProductsPage({
    super.key,
    required this.onTabChanged,
    required this.currentTab,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => ProductsCubit()..fatchProducts(),
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            if (state is ProductsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.masage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ProductsLoding) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductsError) {
              return Center(
                child: Text(
                  state.masage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (state is ProductsLoded) {
              final products = state.productsResponse.data.products;
              if (products.isEmpty) {
                return  Center(
                  child: Text(
                    "لا توجد متاجر منتجات",
                    style: TextStyle(
                      color: appColors.pageBackground,
                      fontSize: 16,
                    ),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                             InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) =>
                                          ProfileCubit()..getProfile(),
                                      child: const Profile(),
                                    ),
                                  ),
                                );
                              },
                              child: Image.asset(
                                'vector/image copy 3.png',
                                width: 40,
                                height: 40,
                              ),
                            ),
                            Image.asset(
                              'vector/image copy 4.png',
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 280,
                              height: 51,
                              decoration: BoxDecoration(
                                  color: appColors.search,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.search_outlined,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Search Products',
                                          hintStyle: TextStyle(
                                              color: appColors.suptext,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Image.asset(
                              'vector/image copy 5.png',
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OnBordingContainer(
                            width: 120,
                            height: 36,
                            color: currentTab == 1
                                ? appColors.primary
                                : appColors.search,
                            widget:  Text(
                              'Products',
                              style: TextStyle(
                                color:  appColors.suptext,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () => onTabChanged(1),
                          ),
                          OnBordingContainer(
                            width: 120,
                            height: 36,
                            color: currentTab == 0
                                ? appColors.primary
                                : appColors.search,
                            widget:  Text(
                              'Categories',
                              style: TextStyle(
                                color:  appColors.suptext,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () => onTabChanged(0),
                          ),
                          OnBordingContainer(
                            width: 120,
                            height: 36,
                            color: currentTab == 2
                                ? appColors.primary
                                : appColors.search,
                            widget:  Text(
                              'Stores',
                              style: TextStyle(
                                color:  appColors.suptext,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onTap: () => onTabChanged(2),
                          ),
                        ],
                      ),
                      GridViewProductsPage(
                        product: products,
                      )
                    ],
                  ),
                ),
              );
            }
            return  Center(
              child: Text(
                "يتم التحميل...",
                style: TextStyle(
                  color: appColors.pageBackground,
                  fontSize: 16,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
