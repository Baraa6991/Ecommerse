import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/models/modelStores.dart';
import 'package:ecommerce/presentation/widgets/storeCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Gridviewstorespage extends StatelessWidget {
  final List<Store> stores;
  const Gridviewstorespage({super.key, required this.stores});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    print("Gridviewstorespage is building");
    return Container(
      height: 520,
      color: appColors.pageBackground,
      child: GridView.builder(
        itemCount: stores.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 0.80,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (ctx, index) {
          final stor = stores[index];
          return Storecard(
            stores: stor,
          );
        },
      ),
    );
  }
}
