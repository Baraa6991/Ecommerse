import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/auth/Profile/profile_cubit.dart';
import 'package:ecommerce/presentation/cubits/home/Archev/ArchevCubit.dart';
import 'package:ecommerce/presentation/cubits/home/Category/category_cubit.dart';
import 'package:ecommerce/presentation/cubits/home/Search/SearchCubit.dart';
import 'package:ecommerce/presentation/cubits/home/Search/SearchState.dart';
import 'package:ecommerce/presentation/pages/auth/profile.dart';
import 'package:ecommerce/presentation/pages/home/ArchivedOrdersScreen.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/gridViewCategoriesPage.dart';
import 'package:ecommerce/presentation/widgets/gridViewProductsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  final Function(int) onTabChanged;
  final int currentTab;

  const CategoriesPage({
    super.key,
    required this.onTabChanged,
    required this.currentTab,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CategoryCubit()..fetchCategory()),
        BlocProvider(create: (_) => SearchCubit()),
      ],
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<CategoryCubit, CategoryState>(
          listener: (context, state) {
            if (state is CategoryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.massage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is CategoryLoding) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CategoryError) {
              return Center(
                child: Text(
                  state.massage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (state is CategoryLoded) {
              final category = state.categoryResponse.data.categories;

              if (category.isEmpty) {
                return  Center(
                  child: Text(
                    "لا توجد متاجر متاحة",
                    style: TextStyle(
                      color: appColors.text,
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
                      const SizedBox(height: 15),
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
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.search_outlined),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      onChanged: (value) {
                                        if (value.length >= 2) {
                                          context
                                              .read<SearchCubit>()
                                              .searchProductByName(value);
                                        } else {
                                          context
                                              .read<SearchCubit>()
                                              .resetSearch(); 
                                        }
                                      },
                                      decoration:  InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Search Products',
                                        hintStyle: TextStyle(
                                          color: appColors.suptext,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) =>
                                          ArchivedCartCubit()
                                            ..fetchArchivedCartItems(),
                                      child: const ArchivedOrdersScreen(),
                                    ),
                                  ),
                                );
                              },
                              child: Image.asset(
                                'vector/image copy 5.png',
                                width: 50,
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
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
                      const SizedBox(height: 5),

                      /// 🔍 BlocBuilder لعرض نتائج البحث أو الفئات
                      BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoading) {
                            return const Padding(
                              padding: EdgeInsets.all(20),
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SearchError) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                state.message,
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (state is SearchLoaded) {
                            if (state.products.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("لا توجد نتائج"),
                              );
                            }
                            return GridViewProductsPage(product: state.products);
                          }

                         
                          return Gridviewcategoriespage(categories: category);
                        },
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
