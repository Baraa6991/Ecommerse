import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/models/modleProducts.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final Dio _dio = Dio();
  ProductsCubit() : super(ProductsInitial());
  Future<void> fatchProducts({int page = 1}) async {
    emit(ProductsLoding());
    try {
      print("🔄 Fetching products from: ${Urls.allProduct}");
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        emit(ProductsError(masage: 'User is not authenticated'));
        return;
      }
      final response = await _dio.get(Urls.allProduct,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }));
      print("✅ Response status code Products: ${response.statusCode}");
      if (response.statusCode == 200 && response.data['successful'] == true) {
        final productsResponse = ProductsResponse.fromJson(response.data);
        print("✅ Products fetched: ${productsResponse.data.products.length}");
        emit(ProductsLoded(productsResponse: productsResponse));
      } else {
        emit(ProductsError(
            masage: 'Failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching categories: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(ProductsError(masage: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(ProductsError(masage: 'Unknown error: $e'));
    }
  }
}
