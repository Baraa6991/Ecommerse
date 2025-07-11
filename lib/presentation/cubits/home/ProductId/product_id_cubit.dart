import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/models/modleProductId.dart';
import 'package:meta/meta.dart';

part 'product_id_state.dart';

class ProductIdCubit extends Cubit<ProductIdState> {
  final Dio _dio=Dio();
  ProductIdCubit() : super(ProductIdInitial());
  Future<void> fetchProductId(int page, int id) async {
  emit(ProductIdLoding());
  try {
    print("🔄 Fetching ProductId from: ${Urls.fatchProducts(id)}");
    final token = await AppSharedPreferences.getToken;
    if (token.isEmpty) {
      emit(ProductIdError(massage: 'User is not authenticated'));
      return;
    }

    final response = await _dio.get(
      Urls.fatchProducts(id),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    print("✅ Response status code Product Id: ${response.statusCode}");
    if (response.statusCode == 200 && response.data != null) {
      final productResponse = StoreResponsess.fromJson(response.data);
      // print("✅ Stores fetched: ${productResponse.data.stores.products.length}");
      emit(ProductIdLoded(storeResponsess: productResponse));
    } else {
      emit(ProductIdError(
          massage: 'Failed with status code: ${response.statusCode}'));
    }
  } on DioException catch (e) {
    print("❌ Dio error while fetching categories: $e");
    if (e.response != null) {
      print("Error response: ${e.response?.data}");
      print("Status code: ${e.response?.statusCode}");
    }
    emit(ProductIdError(massage: 'Exception occurred: ${e.message}'));
  } catch (e) {
    print("❌ Unknown error: $e");
    emit(ProductIdError(massage: 'Unknown error: $e'));
  }
}
}
