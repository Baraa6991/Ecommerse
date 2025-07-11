import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/models/ArchevModle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OldFatorasBodyCubit extends StatelessWidget {
  final String dateTime;
  final List<ArchivedItem> cartItems;

  const OldFatorasBodyCubit({
    super.key,
    required this.dateTime,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: appColors.primary, width: 4.0),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: appColors.primary,
              child: Text(
                'تاريخ الفاتورة: $dateTime',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: appColors.text,
                    ),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (_, __) => Divider(color: appColors.text,),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item.product.name, style: TextStyle(fontSize: 16,color: appColors.text)),
                        Text('x${item.quantity}',
                            style: TextStyle(fontSize: 16,color: appColors.text)),
                        Text('${item.product.price} \$',
                            style: TextStyle(fontSize: 16,color: appColors.text)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
