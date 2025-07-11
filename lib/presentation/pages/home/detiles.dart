import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/home/Cart/cart_cubit.dart';
import 'package:ecommerce/presentation/cubits/home/Cart/cart_state.dart';
import 'package:ecommerce/presentation/cubits/home/Detils/ditles_cubit.dart';
import 'package:ecommerce/presentation/cubits/home/Favorite/favorite_cubit.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/ReadMoreInlineText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Detiles extends StatelessWidget {
  const Detiles({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final favoriteCubit = context.read<FavoriteCubit>();
    favoriteCubit.loadFavorites();
    final TextEditingController numberController = TextEditingController();
    return BlocBuilder<DitlesCubit, DitlesState>(builder: (context, state) {
      if (state is DitlesLoding) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is DitlesError) {
        return Center(
          child: Text(
            state.massage,
            style: const TextStyle(color: Colors.red),
          ),
        );
      } else if (state is DitlesLoded) {
        final product = state.productResponse.product;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: appColors.pageBackground,
            automaticallyImplyLeading: false,
            title: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: appColors.text,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Center(
                  child: Text(
                    product.store,
                    style: TextStyle(
                      color: appColors.text,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                BlocConsumer<FavoriteCubit, FavoriteState>(
                  listener: (context, state) {
                    if (state is FavoriteActionDone) {
                      final message = state.isAdded
                          ? 'تمت الإضافة إلى المفضلة'
                          : 'تم حذف المنتج من المفضلة';
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    } else if (state is FavoriteError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isFav =
                        context.watch<FavoriteCubit>().isFavorite(product.id);
                    return Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(
                          Icons.favorite,
                          color: isFav ? Colors.red : Colors.grey,
                          size: 30,
                        ),
                        onPressed: () {
                          context
                              .read<FavoriteCubit>()
                              .toggleFavorite(product.id);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          backgroundColor: appColors.pageBackground,
          body: Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 22, right: 10, bottom: 25),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Image.network(
                      product.image,
                      width: 350,
                      height: 240,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 28,
                        color: appColors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '\$ ${product.price}',
                      style: TextStyle(
                        fontSize: 28,
                        color: appColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        color: appColors.text,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ReadMoreInlineText(
                      text: product.description,
                      trimLength: 85,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: appColors.pageBackground,
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(color: appColors.primary, width: 3),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: numberController,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: appColors.suptext),
                      decoration: InputDecoration(
                        hintText: 'Enter your Amount',
                        hintStyle: TextStyle(color: appColors.suptext),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  BlocConsumer<CartCubit, CartState>(
                    listener: (context, state) {
                      if (state is CartLoded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('تمت الإضافة إلى السلة بنجاح')),
                        );
                      } else if (state is CartError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.massege)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return OnBordingContainer(
                        width: 370,
                        height: 50,
                        color: appColors.primary,
                        widget: state is CartLoding
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'add to cart',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: appColors.pageBackground,
                                ),
                              ),
                        onTap: () {
                          final quantityText = numberController.text;
                          if (quantityText.isEmpty ||
                              int.tryParse(quantityText) == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('يرجى إدخال كمية صحيحة')),
                            );
                            return;
                          }

                          final quantity = int.parse(quantityText);

                         
                          if (quantity > product.amount) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('الكمية المطلوبة غير متوفرة')),
                            );
                            return;
                          }

                          context.read<CartCubit>().addToCart(
                                quantity: quantity,
                                productId: product.id,
                                availableQuantity: product.amount,
                              );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return SizedBox();
    });
  }
}
