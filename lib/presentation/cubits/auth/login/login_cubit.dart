import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoding());
    try {
      
      final formData = FormData.fromMap({
        'email': email,
        'password': password,
        'remember_me': false,
        'fcm_token': 'test_token',
      });

      final response = await Dio().post(
        Urls.login,
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['successful'] == true) {
        var tokenFromResponse = response.data['token'];
        if (tokenFromResponse != null) {
          await AppSharedPreferences.saveToken(tokenFromResponse);
        }
        emit(LoginSuccessful());
      } else if (response.statusCode == 400) {
        emit(LoginField(
            massage: response.data['message'] ?? 'Validation failed'));
      } else if (response.statusCode == 401) {
        emit(LoginField(massage: 'Incorrect email or password'));
      } else {
        emit(LoginField(massage: 'Unknown error occurred'));
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        emit(
            LoginField(massage: e.response?.data['message'] ?? 'Invalid data'));
      } else if (e.response?.statusCode == 401) {
        emit(LoginField(massage: 'Incorrect credentials'));
      } else {
        emit(LoginField(massage: 'Network error: ${e.message}'));
      }
    } catch (e) {
      emit(LoginField(massage: 'An unexpected error occurred'));
    }
  }
}
