import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/home/Archev/ArchevCubit.dart';
import 'package:ecommerce/presentation/cubits/home/Archev/ArchevState.dart';
import 'package:ecommerce/presentation/pages/home/OldFatorasBodyCubit%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArchivedOrdersScreen extends StatelessWidget {
  const ArchivedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return BlocProvider(
      create: (context) => ArchivedCartCubit()..fetchArchivedCartItems(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appColors.primary,
          title: Text("الفواتير القديمة"),
          centerTitle: true,
        ),
        backgroundColor: appColors.pageBackground,
        body: BlocBuilder<ArchivedCartCubit, ArchivedCartState>(
          builder: (context, state) {
            if (state is ArchivedCartLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ArchivedCartError) {
              return Center(child: Text(state.message));
            } else if (state is ArchivedCartSuccess) {
              if (state.archivedItems.isEmpty) {
                return Center(child: Text("لا توجد فواتير."));
              }

              return ListView.builder(
                itemCount: state.archivedItems.length,
                itemBuilder: (context, index) {
                  final group = state.archivedItems[index];
                  return OldFatorasBodyCubit(
                    dateTime: group.groupOrderedAt,
                    cartItems: group.items,
                  );
                },
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
