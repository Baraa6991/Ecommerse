import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/models/Profile.dart';
import 'package:ecommerce/presentation/widgets/ImagePicker.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  File? selectedImage;

  Future<void> getProfile() async {
    emit(ProfileLoading());
    try {
      final token = await AppSharedPreferences.getToken;
      print('TOKEN: $token');
      if (token.isEmpty) {
        const error = '⚠️ لم يتم العثور على التوكن. يرجى تسجيل الدخول مجددًا.';
        print(error);
        emit(ProfileError(error));
        return;
      }

      final response = await Dio().get(
        Urls.Profile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      print('RESPONSE DATA: ${response.data}');
      if (response.statusCode == 200) {
        final userJson = response.data['data']['user'];
        final userProfile = UserProfile.fromJson(userJson);
        emit(ProfileSuccess(userProfile));
      } else {
        final error =
            '❗ فشل الاتصال بالسيرفر: رمز الاستجابة ${response.statusCode}';
        print(error);
        emit(ProfileError(error));
      }
    } on DioException catch (e) {
      String errorMessage;

      if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = '⏱️ انتهت مهلة الاتصال. تحقق من الإنترنت.';
      } else if (e.type == DioExceptionType.receiveTimeout) {
        errorMessage = '⏱️ انتهت مهلة الاستجابة من السيرفر.';
      } else if (e.type == DioExceptionType.badResponse) {
        errorMessage =
            '❗ خطأ من السيرفر: ${e.response?.statusCode} - ${e.response?.statusMessage}';
      } else if (e.type == DioExceptionType.unknown) {
        errorMessage = '⚠️ خطأ غير معروف: ${e.message}';
      } else {
        errorMessage = '🚫 حدث خطأ أثناء الاتصال: ${e.message}';
      }

      print(errorMessage);
      emit(ProfileError(errorMessage));
    } catch (e) {
      final errorMessage = '🚨 خطأ غير متوقع: ${e.toString()}';
      print(errorMessage);
      emit(ProfileError(errorMessage));
    }
  }

  Future<void> updateProfile({
  required String firstName,
  required String lastName,
  required String location,
  String? email, // جعله اختياريًا
}) async {
  try {
    emit(ProfileLoading());
    print("🚀 بدء تعديل الملف الشخصي...");

    final token = await AppSharedPreferences.getToken;
    print("✅ Token: $token");

    final formData = FormData.fromMap({
      'first_name': firstName,
      'last_name': lastName,
      'location': location,
      // إزالة السطر الذي يضيف البريد الإلكتروني تلقائيًا
      if (selectedImage != null)
        'image': await MultipartFile.fromFile(selectedImage!.path),
    });

    print("📦 formData: ${formData.fields}");
    if (selectedImage != null) {
      print("🖼️ Image path: ${selectedImage!.path}");
    }

    final response = await Dio().post(
      Urls.UpdateProfile,
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    print("📥 Response Status Code: ${response.statusCode}");
    print("📥 Response Data: ${response.data}");

    if (response.statusCode == 200) {
      final updatedUser = UserProfile.fromJson(response.data['data']['user']);
      selectedImage = null; // Reset بعد رفع الصورة
      print("✅ التعديل تم بنجاح: ${updatedUser.firstName} ${updatedUser.lastName}");
      emit(ProfileSuccess(updatedUser));
    } else {
      print("❗ فشل التعديل: ${response.statusCode}");
      emit(ProfileError("❗ فشل التعديل: ${response.statusCode}"));
    }
  } on DioException catch (e) {
    print("📥 Error Response Data: ${e.response?.data}");
    String errorMessage =
        '❗ خطأ من السيرفر: ${e.response?.statusCode} - ${e.response?.statusMessage}';

    if (e.response?.data != null) {
      errorMessage += "\n${e.response?.data}";
    }

    emit(ProfileError(errorMessage));
  }
}

  Future<void> pickAndUploadImage() async {
  try {
    print("🖼️ بدء اختيار صورة من المعرض...");
    final image = await ImagePickerHelper.pickImageFromGallery();
    if (image != null) {
      selectedImage = image;
      print("✅ تم اختيار الصورة: ${image.path}");

      if (state is ProfileSuccess) {
        final user = (state as ProfileSuccess).user;
        print("📤 رفع الصورة مع بيانات المستخدم...");
        await updateProfile(
          firstName: user.firstName,
          lastName: user.lastName,
          location: user.location,
          // لا يتم تمرير البريد الإلكتروني هنا
        );
      }
    } else {
      print("⚠️ لم يتم اختيار صورة.");
    }
  } catch (e) {
    print("🚨 خطأ أثناء اختيار الصورة: ${e.toString()}");
    emit(ProfileError("🚨 خطأ أثناء اختيار الصورة: ${e.toString()}"));
  }
}



// Future<void> logout() async {
//   emit(ProfileLoading());
//   try {
//     final token = await AppSharedPreferences.getToken;

//     if (token.isEmpty) {
//       emit(ProfileError("⚠️ لم يتم العثور على التوكن."));
//       return;
//     }

//     final response = await Dio().post(
//       Urls.logout, 
//       options: Options(
//         headers: {
//           'Authorization': 'Bearer $token',
//           'Accept': 'application/json',
//         },
//       ),
//     );

//     if (response.statusCode == 200 && response.data['successful'] == true) {
      
//       AppSharedPreferences.removeToken(); 
      
//       emit(ProfileLoggedOut("🟢 تم تسجيل الخروج بنجاح."));
//     } else {
//       emit(ProfileError("❌ فشل تسجيل الخروج: ${response.statusCode}"));
//     }
//   } on DioException catch (e) {
//     emit(ProfileError("⚠️ خطأ في الاتصال: ${e.message}"));
//   } catch (e) {
//     emit(ProfileError("🚨 خطأ غير متوقع: ${e.toString()}"));
//   }
// }


}
