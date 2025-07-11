import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/cubits/home/Search/SearchState.dart';
import 'package:ecommerce/presentation/models/modleProducts.dart';

class SearchCubit extends Cubit<SearchState> {
  final Dio _dio = Dio();

  SearchCubit() : super(SearchInitial());

  Future<void> searchProductByName(String query) async {
    print('🔎 بدء البحث عن المنتجات: $query');
    emit(SearchLoading());

    try {
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        emit(SearchError(message: 'User is not authenticated'));
        return;
      }

      final url = Urls.searchProducts();
      final formData = FormData.fromMap({'name': query});

      final response = await _dio.post(
        url,
        data: FormData.fromMap({'name': query}),
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );

      print('📥 حالة الرد: ${response.statusCode}');
      if (response.statusCode == 200 && response.data['successful'] == true) {
        final List<Product> data = List<Product>.from(
          response.data['data']['Products'].map((x) => Product.fromJson(x)),
        );
        print('✅ تم العثور على ${data.length} منتج/منتجات');
        emit(SearchLoaded(products: data));
      } else {
        emit(SearchError(
          message: response.data['message'] ?? 'خطأ غير معروف',
        ));
      }
    } on DioException catch (e) {
      print('❌ خطأ من Dio: ${e.response?.data}');
      emit(SearchError(
        message: e.response?.data['message'] ?? 'فشل في الاتصال',
      ));
    } catch (e) {
      print('🔥 خطأ غير متوقع: $e');
      emit(SearchError(message: 'حدث خطأ غير متوقع'));
    }
  }

  void resetSearch() {
    emit(SearchInitial());
  }
}
