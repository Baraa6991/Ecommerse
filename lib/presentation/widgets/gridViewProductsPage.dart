import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/models/modleProducts.dart';
import 'package:ecommerce/presentation/widgets/productsCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GridViewProductsPage extends StatelessWidget {
  final List<Product> product;
  const GridViewProductsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      height: 520,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: product.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.74,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (ctx, index) {
          final productes = product[index];
          return ProductsCart(product: productes,);
        },
      ),
    );
  }
}
