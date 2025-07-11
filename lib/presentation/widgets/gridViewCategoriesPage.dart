import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/models/modleCatogary.dart';
import 'package:ecommerce/presentation/widgets/categorieCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gridviewcategoriespage extends StatelessWidget {
  final List<Category> categories;

  const Gridviewcategoriespage({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return SingleChildScrollView(
      child: Container(
        height: 558,
        color: appColors.pageBackground,
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 0.94,
            mainAxisSpacing: 15,
            crossAxisSpacing: 15,
          ),
          itemBuilder: (ctx, index) {
            final category = categories[index];
            return Categoriecart(category: category);
          },
        ),
      ),
    );
  }
}
