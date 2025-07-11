import 'package:ecommerce/core/Apis/Network.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/core/cubit/app_color_cubit.dart';
import 'package:ecommerce/presentation/cubits/auth/Regesters/regesterCubit.dart';
import 'package:ecommerce/presentation/cubits/auth/login/login_cubit.dart';
import 'package:ecommerce/presentation/cubits/auth/resetPassword/reset_password_cubit.dart';
import 'package:ecommerce/presentation/pages/onBording/onBording1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Network.init();
  await AppSharedPreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => RegesterCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => ResetPasswordCubit()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(fontFamily: 'sora'),
          home: Onbording1()),
    );
  }
}
