import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/home/Favorite/favorite_cubit.dart'
    show FavoriteCubit;
import 'package:ecommerce/presentation/models/modelFavorite.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favoritecard extends StatelessWidget {
  final FavoriteProduct product;
  const Favoritecard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return OnBordingContainer(
      width: 170,
      height: 90,
      color: appColors.search,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              product.image,
              width: 95,
              height: 95,
              fit: BoxFit.cover,
            ),
          ), 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: TextStyle(
                  color: appColors.suptext,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '\$ ${product.price}',
                style: TextStyle(
                  color: appColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                context.read<FavoriteCubit>().deleteFavorite(product.id);
              },
              icon: Icon(
                Icons.delete_outline,
                color: Color(0xffF35959),
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
