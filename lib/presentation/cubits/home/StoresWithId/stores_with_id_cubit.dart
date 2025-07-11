import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/models/modleStorWithId.dart';
import 'package:meta/meta.dart';

part 'stores_with_id_state.dart';

class StoresWithIdCubit extends Cubit<StoresWithIdState> {
  final Dio _dio = Dio();
  StoresWithIdCubit() : super(StoresWithIdInitial());

  Future<void> fetchCategory(int page, int id) async {
    emit(StoresWithIdLoding());
    try {
      print("🔄 Fetching stores from: ${Urls.fatchSstores(id)}");
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        emit(StoresWithIdError(masage: 'User is not authenticated'));
        return;
      }

      final response = await _dio.get(
        Urls.fatchSstores(id),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("✅ Response status code: ${response.statusCode}");
      if (response.statusCode == 200 && response.data != null) {
        final categoryResponse = CategoryDetailsResponse.fromJson(response.data);
        print("✅ Stores fetched: ${categoryResponse.data.category.stores.data.length}");
        emit(StoresWithIdLoded(categoryResponse: categoryResponse));
      } else {
        emit(StoresWithIdError(masage: 'Failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching categories: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(StoresWithIdError(masage: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(StoresWithIdError(masage: 'Unknown error: $e'));
    }
  }

}
