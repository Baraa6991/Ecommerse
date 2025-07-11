part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoding extends LoginState {}

final class LoginSuccessful extends LoginState {}

final class LoginField extends LoginState {
  final String massage;
  LoginField({required this.massage});
}
