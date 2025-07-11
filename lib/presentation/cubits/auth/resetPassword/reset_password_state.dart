part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoding extends ResetPasswordState {}

final class ResetPasswordSuccessful extends ResetPasswordState {}

final class ResetPasswordField extends ResetPasswordState {}
