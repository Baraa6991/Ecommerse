import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBordingDots extends StatelessWidget {
  final int activeIndex; 

  const OnBordingDots({
    super.key,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        bool isActive = index == activeIndex;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 20 : 10,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? appColors.primary : appColors.suptext,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
