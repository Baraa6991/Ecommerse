import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/models/modleCatogary.dart';
import 'package:ecommerce/presentation/pages/home/storWithId.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categoriecart extends StatelessWidget {
  final Category category;
  const Categoriecart({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return OnBordingContainer(
      width: 170,
      height: 250,
      color: appColors.pageBackground,
      widget: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: category.image != null
                    ? Image.network(
                        category.image!,
                        width: 140,
                        height: 130,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: Colors.grey,
                          width: 140,
                          height: 130,
                          child: const Icon(Icons.error),
                        ),
                      )
                    : Container(
                        color: Colors.grey,
                        width: 140,
                        height: 130,
                        child: const Icon(Icons.store),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                category.name,
                style: TextStyle(
                  color: appColors.text,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
         print("🟢 Going to category with id: ${category.id}");
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => Storwithid(category: category,),
    ),
  );
},
    );
  }
}
