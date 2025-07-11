import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> forgetPassword({required String email}) async {
    emit(ForgetPasswordLoding());
    try {
      var fromdata = FormData.fromMap({'email': email});
      final response = await Dio().post(Urls.forgetPassword, data: fromdata);
      if (response.statusCode == 200 && response.data['successful'] == true) {
        emit(ForgetPasswordSuccessful());
      } else {
        emit(ForgetPasswordField());
      }
    } catch (e) {
      print('Error$e');
    }
  }
}
