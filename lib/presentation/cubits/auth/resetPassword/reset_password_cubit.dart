import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:meta/meta.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  Future<void> verifyCodeAndResetPassword({
    required String email,
    required int otp,
    required String password,
    required String confirmPassword,
  }) async {
    emit(ResetPasswordLoding());
    try {
      var formData = FormData.fromMap({
        'email': email,
        'otp': otp,
        'password': password,
        'password_confirmation': confirmPassword,
      });

      final response = await Dio().post(Urls.veryfiyForReset, data: formData);

      if (response.statusCode == 201 && response.data['successful'] == true) {
        emit(ResetPasswordSuccessful());
      } else {
        emit(ResetPasswordField());
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      emit(ResetPasswordField());
    } catch (e) {
      print('Unexpected error: $e');
      emit(ResetPasswordField());
    }
  }
}
