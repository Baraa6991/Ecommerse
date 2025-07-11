import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/home/Cart/cart_cubit.dart';
import 'package:ecommerce/presentation/cubits/home/Cart/cart_state.dart';
import 'package:ecommerce/presentation/models/modleCart.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/gridViewCart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => CartCubit()..fetchCart(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.pageBackground,
          automaticallyImplyLeading: false,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Text(
                  'Cart',
                  style: TextStyle(
                    color: appColors.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.massege),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            List<CartItem> cartItems = [];
            double totalPrice = 0;

            if (state is CartLoding) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartError) {
              return Center(
                child: Text(
                  state.massege,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (state is CartLodedGet) {
              cartItems = state.cartItemResponse.data.cart.items;
              totalPrice =
                  state.cartItemResponse.data.cart.totalPrice.toDouble();

              if (cartItems.isEmpty) {
                return Center(
                  child: Text(
                    "لا توجد مشتريات متاحة",
                    style: TextStyle(
                      color: appColors.text,
                      fontSize: 16,
                    ),
                  ),
                );
              }
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gridviewcart(cart: cartItems),
                    const SizedBox(height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Price:',
                          style: TextStyle(
                            color: appColors.text,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '\$ $totalPrice',
                          style: TextStyle(
                            color: appColors.primary,
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    OnBordingContainer(
                      width: double.infinity,
                      height: 60,
                      color: appColors.primary,
                      widget: Text(
                        'Save',
                        style: TextStyle(
                          color: appColors.text,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onTap: () {
                        context.read<CartCubit>().placeOrder();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
