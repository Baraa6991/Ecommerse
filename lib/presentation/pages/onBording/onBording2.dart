import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/pages/auth/check.dart';
import 'package:ecommerce/presentation/pages/onBording/onBording1.dart';
import 'package:ecommerce/presentation/pages/onBording/onBording3.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/onBordingDots.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Onbording2 extends StatelessWidget {
  const Onbording2({super.key});

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
            padding: const EdgeInsets.only(top: 40, left: 16),
            child: Image.asset(
              'assets/image copy 2.png',
              height: 383,
              width: 352,
            ),
          ),
          SizedBox(height: 30),
          Text(
            'The Comfort of Smart Shopping',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: appColors.text,
            ),
          ),
          SizedBox(height: 15),
          Text(
            textAlign: TextAlign.center,
            'Browse, select, and receive what you need effortlessly',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: appColors.suptext,
            ),
          ),
          SizedBox(height: 25),
          OnBordingDots(
            activeIndex: 1,
          ),
          SizedBox(
            height: 30,
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Onbording1()),
                    );
                  },
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
                      Image.asset('vector/image copy.png',color: appColors.text),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Onbording3()),
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
