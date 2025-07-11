import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/home/StoresWithId/stores_with_id_cubit.dart';
import 'package:ecommerce/presentation/models/modleCatogary.dart';
import 'package:ecommerce/presentation/widgets/GridViewStorWithId.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Storwithid extends StatelessWidget {
  final Category category;
  const Storwithid({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    print("📦 category.id: ${category.id}");
    return BlocProvider(
      create: (context) => StoresWithIdCubit()..fetchCategory(1, category.id),
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
                  category.name,
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
                    category.image!,
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
        body: BlocConsumer<StoresWithIdCubit, StoresWithIdState>(
          listener: (context, state) {
            if (state is StoresWithIdError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.masage),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is StoresWithIdLoding) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is StoresWithIdError) {
              return Center(
                child: Text(
                  state.masage,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
              );
            } else if (state is StoresWithIdLoded) {
              final categoryes =
                  state.categoryResponse.data.category.stores.data;

              if (categoryes.isEmpty) {
                return  Center(
                  child: Text(
                    "لا توجد متاجر متاحة",
                    style: TextStyle(
                      color: appColors.text,
                      fontSize: 16,
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: GridviewstoresWithIdpage(categoryes: categoryes),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
