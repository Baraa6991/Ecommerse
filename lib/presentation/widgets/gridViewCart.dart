import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
  import 'package:ecommerce/presentation/models/modleCart.dart';
  import 'package:ecommerce/presentation/widgets/cartCard.dart';
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

  class Gridviewcart extends StatelessWidget {
   final List<CartItem> cart;
    const Gridviewcart({super.key, required this.cart});

    @override
    Widget build(BuildContext context) {
      ThemeState appColors = context.watch<ThemeCubit>().state;
      return Container(
        height: 430,
        color: appColors.pageBackground,
        child: GridView.builder(
          itemCount: cart.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
            childAspectRatio: 4.1 ,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (ctx, index) {
            final carts =cart[index];
            return Cartcard(cartItem: carts,);
          },
        ),
      );
    }
  }
