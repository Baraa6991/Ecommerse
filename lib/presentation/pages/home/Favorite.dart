import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/home/Favorite/favorite_cubit.dart';
import 'package:ecommerce/presentation/widgets/gridViewFavoritePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (_) => FavoriteCubit()..fetchFavorite(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.pageBackground,
          automaticallyImplyLeading: false,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: Text(
                  'Favorite',
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
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BlocBuilder<FavoriteCubit, FavoriteState>(
            builder: (context, state) {
              if (state is FavoriteLoding) {
                return Center(child: CircularProgressIndicator());
              } else if (state is FavoriteLoded) {
                return Gridviewfavoritepage(products: state.products);
              } else if (state is FavoriteError) {
                return Center(child: Text(state.message));
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
