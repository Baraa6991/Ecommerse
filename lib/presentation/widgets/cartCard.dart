import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/home/Cart/cart_cubit.dart';
import 'package:ecommerce/presentation/models/modleCart.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cartcard extends StatelessWidget {
  final CartItem cartItem;
  const Cartcard({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final TextEditingController quantityController = TextEditingController();
    final cartCubit = BlocProvider.of<CartCubit>(context);

    return OnBordingContainer(
      width: double.infinity,
      height: 90,
      color: appColors.search,
      widget: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              cartItem.product.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: appColors.suptext,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '\$ ${cartItem.product.price}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: appColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '${cartItem.totalQuantity}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: appColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: appColors.primary),
                onPressed: () {
                  if (cartItem.cartItems.isNotEmpty) {
                    quantityController.text =
                        cartItem.cartItems.first.quantity.toString();
                  } else {
                    quantityController.text = '1';
                  }

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("تعديل الكمية"),
                      content: TextField(
                        controller: quantityController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            hintText: "ادخل الكمية الجديدة"),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            final newQuantity =
                                int.tryParse(quantityController.text);
                            if (newQuantity == null || newQuantity <= 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "الرجاء إدخال كمية صحيحة أكبر من صفر")),
                              );
                              return;
                            }

                            if (cartItem.cartItems.isNotEmpty) {
                              cartCubit.upDateCartItem(
                                id: cartItem.cartItems.first.id,
                                quantity: newQuantity,
                                product_id: cartItem.product.id,
                                availableQuantity: cartItem.totalQuantity,
                              );
                            } else {
                              print("⚠️ لا توجد عناصر سلة لهذا المنتج!");
                            }
                            Navigator.pop(context);
                          },
                          child: const Text("تأكيد"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  if (cartItem.cartItems.isNotEmpty) {
                    final cartItemId = cartItem.cartItems.first.id;
                    cartCubit.deleteCartItem(id: cartItemId);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("لا يوجد عنصر لحذفه")),
                    );
                  }
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color(0xffF35959),
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
