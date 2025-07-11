part of 'code_ckeck_cubit.dart';

@immutable
abstract class CodeCkeckState {}

class CodeCkeckInitial extends CodeCkeckState {}

class CodeCkeckLoding extends CodeCkeckState {}

class CodeCkeckSuccessful extends CodeCkeckState {}

class CodeCkeckFaild extends CodeCkeckState {
  final String? message;
  CodeCkeckFaild({this.message});
}

class ResendOTPSuccessful extends CodeCkeckState {
  final String message;
  ResendOTPSuccessful({required this.message});
}
