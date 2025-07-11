import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/home/ProductId/product_id_cubit.dart';
import 'package:ecommerce/presentation/models/modleStorWithId.dart';
import 'package:ecommerce/presentation/widgets/GridViewProductId.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productid extends StatelessWidget {
  final StoresId store;

  const Productid({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => ProductIdCubit()..fetchProductId(1, store.id),
      child: Scaffold(
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
                  store.name,
                  style: TextStyle(
                    color: appColors.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    store.image!,
                    scale: 1.5,
                    width: 46,
                    height: 46,
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: appColors.pageBackground,
        body: BlocConsumer<ProductIdCubit, ProductIdState>(
          listener: (context, state) {
            if (state is ProductIdError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.massage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is ProductIdLoding) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductIdError) {
              return Center(
                child: Text(
                  state.massage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (state is ProductIdLoded) {
              final products = state.storeResponsess.data.store.products;
              if (products.isEmpty) {
                return  Center(
                  child: Text(
                    "لا توجد متاجر منتجات",
                    style: TextStyle(
                      color: appColors.pageBackground,
                      fontSize: 16,
                    ),
                  ),
                );
              }
              return Padding(
                 padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child:  Gridviewproductid(
                  productss: products,
                ),
              );
            }
             return const SizedBox();
          },
        ),
      ),
    );
  }
}
