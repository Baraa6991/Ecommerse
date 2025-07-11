import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/models/modleCatogary.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final Dio _dio = Dio();
  CategoryCubit() : super(CategoryInitial());

  Future<void> fetchCategory({int page = 1}) async {
    emit(CategoryLoding());
    try {
      print("🔄 Fetching stores from: ${Urls.allCategory}");
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        emit(CategoryError(massage: 'User is not authenticated'));
        return;
      }

      final response = await _dio.get(
        Urls.allCategory,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("✅ Response status code: ${response.statusCode}");
      if (response.statusCode == 200 && response.data != null) {
        final categoryResponse = CategoryResponse.fromJson(response.data);
        print("✅ Categories fetched: ${categoryResponse.data.categories.length}");
        emit(CategoryLoded(categoryResponse: categoryResponse));
      } else {
        emit(CategoryError(massage: 'Failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching categories: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(CategoryError(massage: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(CategoryError(massage: 'Unknown error: $e'));
    }
  }
}


