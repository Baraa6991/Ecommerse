import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/cubits/home/Cart/cart_state.dart';
import 'package:ecommerce/presentation/models/modleCart.dart';

class CartCubit extends Cubit<CartState> {
  final Dio _dio = Dio();
  CartCubit() : super(CartInitial());
  Future<void> addToCart({
    required int quantity,
    required int productId,
    required int availableQuantity,
  }) async {
    print('🚀 بدأ تنفيذ addToCart');
    emit(CartLoding());
    print('📦 تم إطلاق الحالة: CartLoding');

    if (quantity > availableQuantity) {
      print(
          '❌ الكمية المطلوبة ($quantity) أكبر من المتوفرة ($availableQuantity)');
      emit(CartError(massege: 'الكمية المطلوبة غير متوفرة'));
      return;
    }

    try {
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        emit(CartError(massege: 'User is not authenticated'));
        return;
      }
      print('🛠️ يتم تجهيز البيانات للإرسال');
      final formData = FormData.fromMap({
        'quantity': quantity,
        'product_id': productId,
        'remember_me': false,
        'fcm_token': 'test_token',
      });

      print('🌐 يتم إرسال الطلب إلى السيرفر...');
      final response = await Dio().post(
        Urls.addToCart,
        data: formData,
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );

      print('📥 تم استلام الرد: ${response.statusCode}');
      if (response.statusCode == 201 && response.data['successful'] == true) {
        print('✅ تمت الإضافة بنجاح');
        final token = response.data['token'];
        if (token != null) {
          print('🔑 حفظ التوكن: $token');
          await AppSharedPreferences.saveToken(token);
        }
        emit(CartLoded());
        print('📦 تم إطلاق الحالة: CartLoded');
      } else {
        print('⚠️ فشل في الإضافة: ${response.data['message']}');
        emit(CartError(massege: response.data['message'] ?? 'خطأ غير معروف'));
      }
    } on DioException catch (e) {
      print('📡 فشل الاتصال بالسيرفر: ${e.response?.data}');
      emit(CartError(massege: e.response?.data['message'] ?? 'فشل في الاتصال'));
    } catch (e) {
      print('🔥 حدث خطأ غير متوقع: $e');
      emit(CartError(massege: 'حدث خطأ غير متوقع'));
    }
  }

  Future<void> fetchCart() async {
    emit(CartLoding());

    try {
      print("🔄 Fetching stores from: ${Urls.fatchCart}");
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        emit(CartError(massege: 'User is not authenticated'));
        return;
      }

      final response = await _dio.get(
        Urls.fatchCart,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      print("📦 JSON Data: ${response.data}");
      print("🔎 data: ${response.data['data']}");
      print("🧺 Cart: ${response.data['data']['Cart']}");

      print("✅ Response status code: ${response.statusCode}");
      if (response.statusCode == 200 && response.data != null) {
        final cartResponse = CartResponse.fromJson(response.data);
        print("✅ Categories fetched: ${cartResponse.data}");
        emit(CartLodedGet(cartItemResponse: cartResponse));
      } else {
        emit(CartError(
            massege: 'Failed with status code: ${response.statusCode}'));
      }
    } on DioException catch (e) {
      print("❌ Dio error while fetching categories: $e");
      if (e.response != null) {
        print("Error response: ${e.response?.data}");
        print("Status code: ${e.response?.statusCode}");
      }
      emit(CartError(massege: 'Exception occurred: ${e.message}'));
    } catch (e) {
      print("❌ Unknown error: $e");
      emit(CartError(massege: 'Unknown error: $e'));
    }
  }

  Future<void> upDateCartItem({
    required int id,
    required int quantity,
    required int product_id,
    required int availableQuantity,
  }) async {
    print(
        "🟡 بدء تحديث العنصر: id=$id, quantity=$quantity, product_id=$product_id");

    emit(CartLoding());

    try {
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        print("🔴 لم يتم العثور على التوكن");
        emit(CartError(massege: 'User is not authenticated'));
        return;
      }

      final url =
          "${Urls.updateCart(id)}?quantity=$quantity&product_id=$product_id";

      print("📡 إرسال طلب PUT إلى: $url");

      final response = await _dio.put(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      print("📥 تم استقبال الاستجابة: ${response.statusCode}");

      if (response.statusCode == 200 && response.data['successful'] == true) {
        print("✅ تم تحديث السلة بنجاح: ${response.data['message']}");
        await fetchCart();
      } else {
        print("⚠️ فشل في تحديث السلة: ${response.data}");
        emit(CartError(
          massege: response.data['message'] ?? 'فشل في تحديث السلة',
        ));
      }
    } on DioException catch (e) {
      print("❌ خطأ في Dio: ${e.response?.data}");
      emit(CartError(
        massege: e.response?.data['message'] ?? 'فشل الاتصال بالخادم',
      ));
    } catch (e) {
      print("❌ حدث خطأ غير متوقع: $e");
      emit(CartError(massege: 'حدث خطأ غير متوقع أثناء التحديث'));
    }
  }

  Future<void> deleteCartItem({
    required int id,
  }) async {
    emit(CartLoding());
    try {
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        print("🔴 لم يتم العثور على التوكن");
        emit(CartError(massege: 'User is not authenticated'));
        return;
      }
      final response = await _dio.delete(
        Urls.deletCart(id),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final message = response.data['message'] ?? 'تم حذف العنصر بنجاح';
        emit(CartLoded());
        await fetchCart();
      } else {
        emit(CartError(massege: 'فشل الحذف: ${response.data['message']}'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        emit(CartError(massege: e.response?.data['message'] ?? 'خطأ في الحذف'));
      } else {
        emit(CartError(massege: 'فشل الاتصال بالخادم'));
      }
    } catch (e) {
      emit(CartError(massege: 'حدث خطأ غير متوقع: $e'));
    }
  }

  Future<void> placeOrder() async {
    print('🚀 بدأ تنفيذ placeOrder');
    emit(CartLoding());
    print('📦 تم إطلاق الحالة: CartLoding');

    try {
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        emit(CartError(massege: 'User is not authenticated'));
        return;
      }

      print('🌐 يتم إرسال الطلب إلى السيرفر...');
      final response = await Dio().post(
        Urls.placeOrder,
        options: Options(headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );

      print('📥 تم استلام الرد: ${response.statusCode}');
      if (response.statusCode == 200 && response.data['successful'] == true) {
        print('✅ تم الطلب بنجاح');
        emit(CartLoded());
        print('📦 تم إطلاق الحالة: CartLoded');
      } else {
        print('⚠️ فشل في إتمام الطلب: ${response.data['message']}');
        emit(CartError(massege: response.data['message'] ?? 'خطأ غير معروف'));
      }
    } on DioException catch (e) {
      print('📡 فشل الاتصال بالسيرفر: ${e.response?.data}');
      emit(CartError(massege: e.response?.data['message'] ?? 'فشل في الاتصال'));
    } catch (e) {
      print('🔥 حدث خطأ غير متوقع: $e');
      emit(CartError(massege: 'حدث خطأ غير متوقع'));
    }
  }

  
}
