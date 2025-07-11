import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/auth/ForgetPassword/forget_password_cubit.dart';
import 'package:ecommerce/presentation/cubits/auth/login/login_cubit.dart';
import 'package:ecommerce/presentation/pages/auth/forgetpassword.dart';
import 'package:ecommerce/presentation/pages/auth/register%20.dart';
import 'package:ecommerce/presentation/pages/auth/successful.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/TextFileidApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;

    final TextEditingController phoneController = TextEditingController();
    final TextEditingController email = TextEditingController();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoding) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoginSuccessful) {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: LoginCubit(),
                child: Successful(),
              ),
            ),
          );
        } else if (state is LoginField) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.massage),
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
                Center(
                    child: Image.asset(
                  'assets/image copy 3.png',
                  width: 270,
                  height: 270,
                )),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Welcome Back',
                  style: TextStyle(
                      color: appColors.text,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Glad to see you again',
                  style: TextStyle(
                    color: appColors.text,
                    fontSize: 26,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFileidApp(
                  hintText: 'Enter your email',
                  icon: Icons.phone_outlined,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFileidApp(
                  hintText: 'Enter your Password',
                  icon: Icons.visibility,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.emailAddress,
                  controller: phoneController,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: ForgetPasswordCubit(),
                            child: Forgetpassword(),
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'I Forget My Password',
                      style: TextStyle(
                        fontSize: 20,
                        color: appColors.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: OnBordingContainer(
                    width: 350,
                    height: 50,
                    color: appColors.primary,
                    widget: Text(
                      'LOG IN',
                      style:
                          TextStyle(color: appColors.text, fontSize: 24),
                    ),
                    onTap: () async {
                      await BlocProvider.of<LoginCubit>(context).login(
                        email: email.text,
                        password: phoneController.text,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Do’nt have account ?  ',
                        style: TextStyle(
                            color: appColors.text,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Register()),
                          );
                        },
                        child: Text(
                          'REGISTER',
                          style: TextStyle(
                            color: appColors.primary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
