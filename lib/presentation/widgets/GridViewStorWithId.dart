import 'package:ecommerce/presentation/models/modleStorWithId.dart';
import 'package:ecommerce/presentation/widgets/StorWithIdCard.dart';
import 'package:flutter/material.dart';

class GridviewstoresWithIdpage extends StatelessWidget {
  final List<StoresId> categoryes;
  const GridviewstoresWithIdpage({
    super.key,
    required this.categoryes,
  });

  @override
  Widget build(BuildContext context) {
    print("Gridviewstorespage is building");
    return GridView.builder(
      itemCount: categoryes.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 0.80,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (ctx, index) {
        final categories = categoryes[index];
        return Storwithidcard(
          storesId: categories,
        );
      },
      
    );
  }
}
