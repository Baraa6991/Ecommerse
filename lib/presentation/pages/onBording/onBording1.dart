import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/pages/auth/check.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/onBordingDots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'onBording2.dart';

class Onbording1 extends StatelessWidget {
  const Onbording1({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 68, left: 315),
            child: OnBordingContainer(
              color: appColors.primary,
              width: 54,
              height: 36,
              widget: Text('Skip'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Check()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 16),
            child: Image.asset(
              'assets/image.png',
              height: 383,
              width: 352,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Your Time Is Our Priority',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: appColors.text,
            ),
          ),
          SizedBox(height: 15),
          Text(
            textAlign: TextAlign.center,
            'Fast and convenient delivery service to save your time and effort',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: appColors.suptext,
            ),
          ),
          SizedBox(height: 25),
          OnBordingDots(
            activeIndex: 0,
          ),
          SizedBox(
            height: 45,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OnBordingContainer(
                  color: appColors.primary,
                  width: 60,
                  height: 40,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('vector/image.png',color: appColors.text),
                      Text(
                        'Pre',
                        style: TextStyle(color: appColors.text),
                      ),
                    ],
                  ),
                ),
                OnBordingContainer(
                  color: appColors.primary,
                  width: 60,
                  height: 40,
                  widget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(color: appColors.text),
                      ),
                      Image.asset('vector/image copy.png',color: appColors.text,),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Onbording2()),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
