import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/models/modelDetiles.dart';
import 'package:meta/meta.dart';

part 'ditles_state.dart';

class DitlesCubit extends Cubit<DitlesState> {
  final Dio _dio = Dio();
  DitlesCubit() : super(DitlesInitial());
  Future<void> fetchProductsDetiles(int id) async {
    emit(DitlesLoding());
    try {
      print("🔄 Fetching ProductDetiles from: ${Urls.fatchProductsDetils(id)}");

       final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        emit(DitlesError(massage: 'User is not authenticated'));
        return;
      }

      final response = await _dio.get(
        Urls.fatchProductsDetils(id),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      print("✅ Response status code: ${response.statusCode}");
      if (response.statusCode == 200 && response.data['successful'] == true) {
        final productDetiles = ProductResponse.fromJson(response.data);
        print("✅ Categories fetched: ${productDetiles.product}");
        emit(DitlesLoded(productResponse: productDetiles));
      } else {
        emit(DitlesError(
            massage: 'Failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching categories: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(DitlesError(massage: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(DitlesError(massage: 'Unknown error: $e'));
    }
  }
}
