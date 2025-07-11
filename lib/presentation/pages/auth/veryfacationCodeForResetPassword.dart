import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/core/cubit/app_color_state.dart';
import 'package:ecommerce/presentation/cubits/auth/resetPassword/reset_password_cubit.dart';
import 'package:ecommerce/presentation/pages/auth/resetPassword.dart';
import 'package:ecommerce/presentation/widgets/Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VeryfacationCodeForResetPassword extends StatelessWidget {
  final String email;
  const VeryfacationCodeForResetPassword({
    super.key,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    ThemeState appColors = context.watch<ThemeCubit>().state;
    final TextEditingController otpController = TextEditingController();

    return Scaffold(
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
                'Verification Code',
                style: TextStyle(
                  color: appColors.text,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'We have sent the verification code to your email address',
                style: TextStyle(
                  color: appColors.suptext,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 100),
              PinCodeTextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: appColors.pageBackground,
                  selectedColor: appColors.primary,
                  selectedFillColor: appColors.pageBackground,
                  inactiveColor: appColors.text,
                  inactiveFillColor: appColors.pageBackground,
                  activeColor: appColors.primary,
                ),
                backgroundColor: appColors.pageBackground,
                textStyle: TextStyle(color: appColors.text),
                enableActiveFill: true,
              ),
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: OnBordingContainer(
                  width: 350,
                  height: 50,
                  color: appColors.primary,
                  widget: Text(
                    'Confirm',
                    style: TextStyle(color: appColors.text, fontSize: 24),
                  ),
                  onTap: () {
                    int otp = int.tryParse(otpController.text) ?? 0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: ResetPasswordCubit(),
                          child: ResetPassword(
                            email: email,
                            otp: otp,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 100),
              TextButton(
                onPressed: () {},
                child: Center(
                  child: Text(
                    'Resend OTP',
                    style: TextStyle(
                      fontSize: 30,
                      color: appColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
