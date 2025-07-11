import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/auth/login/login_cubit.dart';
import 'package:ecommerce/presentation/pages/auth/login.dart';
import 'package:ecommerce/presentation/pages/auth/register%20.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Check extends StatelessWidget {
  const Check({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    return Scaffold(
        backgroundColor: appColors.pageBackground,
        body: Padding(
          padding: const EdgeInsets.only(top: 140),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'vector/image copy 2.png',
                    width: 280,
                    height: 260,
                  ),
                ),
                SizedBox(
                  height: 76,
                ),
                Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: appColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          'Hello',
                          style: TextStyle(
                              color: appColors.text,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Do you have an account ?',
                          style: TextStyle(
                              color: appColors.text,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              OnBordingContainer(
                                width: 153,
                                height: 51,
                                color: appColors.pageBackground,
                                widget: Text(
                                  'Yes',
                                  style: TextStyle(
                                    color: appColors.primary,
                                    fontSize: 20,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                        value: LoginCubit(),
                                        child: Login(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: OnBordingContainer(
                                  width: 153,
                                  height: 51,
                                  color: appColors.primary,
                                  widget: Text(
                                    'No',
                                    style: TextStyle(
                                      color: appColors.pageBackground,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Register()),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            textAlign: TextAlign.center,
                            'Welcome to our application',
                            style: TextStyle(
                              color: appColors.text,
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
