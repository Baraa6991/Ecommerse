import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/pages/home/mainScreen.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Successful extends StatelessWidget {
  const Successful({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: appColors.text,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Image.asset(
                  'vector/image copy 2.png',
                  width: 60,
                  height: 58,
                ),
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/image copy 4.png',
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              'Success',
              style: TextStyle(
                color: appColors.text,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Congratulations! You have been successfully authenticated',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: appColors.suptext,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            OnBordingContainer(
              width: 343,
              height: 51,
              color: appColors.primary,
              widget: Text(
                'Continue',
                style: TextStyle(
                  color: appColors.text,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
