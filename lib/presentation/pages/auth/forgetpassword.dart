import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/auth/ForgetPassword/forget_password_cubit.dart';
import 'package:ecommerce/presentation/pages/auth/veryfacationCodeForResetPassword.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/TextFileidApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Forgetpassword extends StatelessWidget {
  const Forgetpassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    final TextEditingController email = TextEditingController();

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordLoding) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ForgetPasswordSuccessful) {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  VeryfacationCodeForResetPassword(email: email.text),
            ),
          );
        } else if (state is ForgetPasswordField) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('فشل التحقق من الرمز'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: appColors.pageBackground,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back,
                          color: appColors.text, size: 30),
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
                const SizedBox(height: 30),
                Text(
                  'Forget Password ',
                  style: TextStyle(
                    color: appColors.text,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Enter Your Email ',
                  style: TextStyle(
                    color: appColors.suptext,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 100),
                TextFileidApp(
                  hintText: 'Enter your Email',
                  icon: Icons.email_outlined,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                ),
                const SizedBox(height: 100),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: OnBordingContainer(
                    width: 350,
                    height: 50,
                    color: appColors.primary,
                    widget: Text(
                      'Save',
                      style:
                          TextStyle(color: appColors.text, fontSize: 24),
                    ),
                    onTap: () async {
                      BlocProvider.of<ForgetPasswordCubit>(context)
                          .forgetPassword(email: email.text);
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
