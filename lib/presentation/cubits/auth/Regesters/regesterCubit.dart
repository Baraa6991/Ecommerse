import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ecommerce/core/Apis/Urls.dart';
import 'regesterState.dart';

class RegesterCubit extends Cubit<Regesterstate> {
  RegesterCubit() : super(RegesterInit());

  Future<void> regester({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String location,
    String? imagePath,
  }) async {
    emit(RegesterLoding());

    try {
      var formData = dio.FormData.fromMap({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "location": location,
        if (imagePath != null)
          'image': await dio.MultipartFile.fromFile(imagePath,
              filename: "image.png"),
      });

      final response = await dio.Dio().post(Urls.register, data: formData);

      if (response.statusCode == 201 && response.data['successful'] == true) {
        emit(RegesterSuccessful());
      } else {
        emit(RegesterField(message: 'Registration failed. Please try again.'));
      }
    } catch (e) {
      emit(RegesterField(message: 'An error occurred. Please try again.'));
    }
  }
}
