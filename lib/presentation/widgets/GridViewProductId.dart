import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/models/modleProductId.dart';
import 'package:ecommerce/presentation/widgets/prductIdCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gridviewproductid extends StatelessWidget {
  final List<Productss> productss;
  const Gridviewproductid({super.key, required this.productss});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Container(
      height: 670,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: productss.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.70,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (ctx, index) {
          final prductsss = productss[index];
          return Prductidcard(
            product: prductsss,
          );
        },
      ),
    );
  }
}
