import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart' as dio;

part 'code_ckeck_state.dart';

class CodeCkeckCubit extends Cubit<CodeCkeckState> {
  CodeCkeckCubit() : super(CodeCkeckInitial());
  Future<void> checkingCode(
      {required String email, required String otp}) async {
    emit(CodeCkeckLoding());
    try {
      final dioInstance = dio.Dio();
      dioInstance.options.headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

      final response = await dioInstance.post(
        Urls.codecheck,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      if (response.statusCode == 200 && response.data['successful'] == true) {
        var tokenFromResponse = response.data['data']?['token'];

        if (tokenFromResponse != null) {
          await AppSharedPreferences.saveToken(tokenFromResponse);
        }
        emit(CodeCkeckSuccessful());
      } else {
        emit(CodeCkeckFaild(
            message: response.data['message'] ?? 'رمز التحقق خاطئ'));
      }
    } catch (e) {
      emit(CodeCkeckFaild(message: 'حدث خطأ أثناء التحقق'));
    }
  }

  Future<void> resendOTP(
      {required String email, required String subject}) async {
    emit(CodeCkeckLoding());
    try {
      final dioInstance = dio.Dio();

      dio.FormData formData = dio.FormData.fromMap({
        'email': email,
      });

      final response = await dioInstance.post(
        '${Urls.resendOTP}?subject=$subject',
        data: formData,
        options: dio.Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['successful'] == true) {
        emit(ResendOTPSuccessful(message: response.data['message']));
      } else {
        emit(CodeCkeckFaild(
            message: response.data['message'] ?? 'فشل في إرسال الرمز'));
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        emit(CodeCkeckFaild(
            message: e.response?.data['message'] ?? 'خطأ في السيرفر'));
      } else {
        emit(CodeCkeckFaild(message: 'حدث خطأ في الاتصال'));
      }
    } catch (e) {
      emit(CodeCkeckFaild(message: 'حدث خطأ غير متوقع'));
    }
  }
}
