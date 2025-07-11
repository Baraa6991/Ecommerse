import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/models/modleStorWithId.dart';
import 'package:ecommerce/presentation/pages/home/productId.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Storwithidcard extends StatelessWidget {
  final StoresId storesId;
  const Storwithidcard({
    super.key,
    required this.storesId,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    print("Gridviewstorespage is ");
    return OnBordingContainer(
      width: 180,
      height: 230,
      color: appColors.search,
      widget: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: storesId.image != null
                  ? Image.network(
                      storesId.image!,
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
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  storesId.name,
                  style: TextStyle(
                    color: appColors.suptext,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    'vector/image copy 8.png',
                    height: 14,
                    width: 14,
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      storesId.address,
                      style: TextStyle(
                        color: appColors.suptext,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Image.asset(
                    'vector/image copy 9.png',
                    width: 15,
                    height: 15,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'stores.category',
                      style: TextStyle(
                        color: appColors.suptext,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        print("🟢 Going to category with id: ${storesId.id}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Productid(
              store: storesId,
            ),
          ),
        );
      },
    );
  }
}
