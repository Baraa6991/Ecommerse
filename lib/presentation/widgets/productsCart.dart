import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/home/Cart/cart_cubit.dart';
import 'package:ecommerce/presentation/cubits/home/Detils/ditles_cubit.dart';
import 'package:ecommerce/presentation/cubits/home/Favorite/favorite_cubit.dart';
import 'package:ecommerce/presentation/models/modleProducts.dart';
import 'package:ecommerce/presentation/pages/home/detiles.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsCart extends StatelessWidget {
  final Product product;
  const ProductsCart({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return OnBordingContainer(
      width: 170,
      height: 250,
      color: appColors.search,
      widget: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.image,
                width: 140,
                height: 130,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.name,
                  style: TextStyle(
                    color: appColors.suptext,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ), SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.store,
                  style: TextStyle(
                    color: appColors.suptext,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ ${product.price}',
                    style: TextStyle(
                      color: appColors.suptext,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'vector/image copy 6.png',
                    width: 30,
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => DitlesCubit()..fetchProductsDetiles(product.id),
          ),
          BlocProvider(create: (_) => FavoriteCubit()),
          BlocProvider(create: (_) => CartCubit()),  
        ],
        child: Detiles(),
      ),
    ),
  );
},

    );
  }
}
