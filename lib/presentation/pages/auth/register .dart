import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/auth/Regesters/regesterCubit.dart';
import 'package:ecommerce/presentation/cubits/auth/Regesters/regesterState.dart';
import 'package:ecommerce/presentation/cubits/auth/codeCheck/code_ckeck_cubit.dart';
import 'package:ecommerce/presentation/pages/auth/codecheck.dart';
import 'package:ecommerce/presentation/pages/auth/login.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:ecommerce/presentation/widgets/TextFileidApp.dart';
import 'package:ecommerce/presentation/widgets/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final imagePickerController = Get.put(ImagePickerController());

    final TextEditingController firstnameController = TextEditingController();
    final TextEditingController lastnameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final TextEditingController locationController = TextEditingController();

    return BlocListener<RegesterCubit, Regesterstate>(
      listener: (context, state) {
        if (state is RegesterLoding) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is RegesterSuccessful) {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: CodeCkeckCubit(),
                child: Codecheck(email: emailController.text),
              ),
            ),
          );
        } else if (state is RegesterField) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
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
                  height: 60,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        color: appColors.text,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      'vector/image copy 2.png',
                      width: 60,
                      height: 58,
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Create account',
                  style: TextStyle(
                    color: appColors.text,
                    fontSize: 26,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                TextFileidApp(
                  hintText: 'First name',
                  icon: Icons.person_outline_rounded,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.name,
                  controller: firstnameController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFileidApp(
                  hintText: 'Last name',
                  icon: Icons.person_outline_rounded,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.name,
                  controller: lastnameController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFileidApp(
                  hintText: 'Enter your email',
                  icon: Icons.email_outlined,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
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
                  controller: passwordController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFileidApp(
                  hintText: 'Confirm your Password',
                  icon: Icons.visibility,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.emailAddress,
                  controller: confirmPasswordController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFileidApp(
                  hintText: 'Enter your location',
                  icon: Icons.location_on_outlined,
                  borderColor: appColors.primary,
                  backgroundColor: appColors.pageBackground,
                  hintColor: appColors.suptext,
                  iconColor: appColors.suptext,
                  textColor: appColors.suptext,
                  keyboardType: TextInputType.name,
                  controller: locationController,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: OnBordingContainer(
                    width: 350,
                    height: 50,
                    color: appColors.primary,
                    widget: Text(
                      'REGISTER',
                      style:
                          TextStyle(color: appColors.text, fontSize: 24),
                    ),
                    onTap: () async {
                      await BlocProvider.of<RegesterCubit>(context).regester(
                        firstName: firstnameController.text,
                        lastName: lastnameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        passwordConfirmation: confirmPasswordController.text,
                        location: locationController.text,
                        imagePath: imagePickerController.selectedImage != null
                            ? imagePickerController.selectedImage!.path
                            : null,
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
                        'Already have account ?  ',
                        style: TextStyle(
                            color: appColors.text,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          'LOGIN',
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

class LodingCenter extends StatelessWidget {
  const LodingCenter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Loding',
        style: TextStyle(fontSize: 40),
      ),
    );
  }
}
