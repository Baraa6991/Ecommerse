import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/models/modelFavorite.dart';
import 'package:ecommerce/presentation/widgets/favoriteCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gridviewfavoritepage extends StatelessWidget {
  final List<FavoriteProduct> products;
  const Gridviewfavoritepage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      height: 670,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 4.1 ,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (ctx, index) {
          return Favoritecard(product: products[index]);
        },
      ),
    );
  }
}
