import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/auth/login/login_cubit.dart';
import 'package:ecommerce/presentation/cubits/auth/resetPassword/reset_password_cubit.dart';
import 'package:ecommerce/presentation/pages/auth/login.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/TextFileidApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatelessWidget {
  final String email;
  final int otp;
  const ResetPassword({super.key, required this.email, required this.otp});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final TextEditingController password = TextEditingController();
    final TextEditingController password_confirmation = TextEditingController();

    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordLoding) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ResetPasswordSuccessful) {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: LoginCubit(),
                child: Login(),
              ),
            ),
          );
        } else if (state is ResetPasswordField) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('state.massage'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 280),
                  child: Image.asset(
                    'vector/image copy 2.png',
                    width: 60,
                    height: 58,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Enter The New Password',
                  style: TextStyle(
                      color: appColors.text,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFileidApp(
                  hintText: 'Enter your password',
                  icon: Icons.phone_outlined,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.emailAddress,
                  controller: password,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFileidApp(
                  hintText: 'Confirmation Passwors',
                  icon: Icons.phone_outlined,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.emailAddress,
                  controller: password_confirmation,
                ),
                SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: OnBordingContainer(
                    width: 350,
                    height: 50,
                    color: appColors.primary,
                    widget: Text(
                      'LOG IN',
                      style: TextStyle(color: appColors.text, fontSize: 24),
                    ),
                    onTap: () {
                      BlocProvider.of<ResetPasswordCubit>(context)
                          .verifyCodeAndResetPassword(
                        email: email,
                        otp: otp,
                        password: password.text,
                        confirmPassword: password_confirmation.text,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
