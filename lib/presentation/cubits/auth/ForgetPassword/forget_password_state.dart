part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoding extends ForgetPasswordState {}

final class ForgetPasswordSuccessful extends ForgetPasswordState {}

final class ForgetPasswordField extends ForgetPasswordState {}
