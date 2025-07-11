import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/cubits/home/Stores/stores_state.dart';
import 'package:ecommerce/presentation/models/modelStores.dart';

class StoreCubit extends Cubit<StoreState> {
  final Dio _dio = Dio();

  StoreCubit() : super(StoreInitial());

  Future<void> fetchStores({int page = 1}) async {
    emit(StoreLoading());

    try {
      print("🔄 Fetching stores from: ${Urls.allStore}");

      final token = await AppSharedPreferences.getToken;

      if (token.isEmpty) {
        emit(StoreError('User is not authenticated'));
        return;
      }

      final response = await _dio.get(
        Urls.allStore,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("✅ Response status code: ${response.statusCode}");
      print("✅ Response data: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        if (response.data is Map<String, dynamic>) {
          try {
            final storeResponse = StoreResponse.fromJson(response.data);
            emit(StoreLoaded(storeResponse));
          } catch (e) {
            emit(StoreError('Error parsing response data: $e'));
          }
        } else {
          emit(StoreError('Unexpected response format: ${response.data.runtimeType}'));
        }
      } else {
        emit(StoreError('Failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching stores: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(StoreError('Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(StoreError('Unknown error: $e'));
    }
  }
}
