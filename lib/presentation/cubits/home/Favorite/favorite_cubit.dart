import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/models/modelFavorite.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final Dio _dio = Dio();
  FavoriteCubit() : super(FavoriteInitial());

  List<int> favoriteIds = [];

  bool isFavorite(int id) => favoriteIds.contains(id);

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('favorite_ids') ?? [];
    favoriteIds = ids.map(int.parse).toList();
    emit(FavoriteActionDone(isAdded: true));
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'favorite_ids', favoriteIds.map((e) => e.toString()).toList());
  }

  Future<void> toggleFavorite(int id) async {
    emit(FavoriteLoding());

    final token = await AppSharedPreferences.getToken;
    if (token.isEmpty) {
      emit(FavoriteError(message: 'User is not authenticated'));
      return;
    }

    try {
      if (isFavorite(id)) {
        final response = await _dio.delete(
          Urls.deletFavorite(id),
          data: {'product_id': id},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }),
        );

        if (response.statusCode == 200 && response.data['successful'] == true) {
          favoriteIds.remove(id);
          await _saveFavorites();
          emit(FavoriteActionDone(isAdded: false));
        } else {
          emit(FavoriteError(message: response.data['message'] ?? 'حدث خطأ'));
        }
      } else {
        // إضافة إلى المفضلة
        final response = await _dio.post(
          Urls.postFavorite(id),
          data: {'product_id': id},
          options: Options(headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          }),
        );

        if (response.statusCode == 200 && response.data['successful'] == true) {
          favoriteIds.add(id);
          await _saveFavorites();
          emit(FavoriteActionDone(isAdded: true));
        } else {
          emit(FavoriteError(message: response.data['message'] ?? 'حدث خطأ'));
        }
      }
    } catch (e) {
      emit(FavoriteError(message: "فشل الاتصال بالخادم: $e"));
    }
  }

  Future<void> fetchFavorite() async {
    emit(FavoriteLoding());

    try {
      final token = await AppSharedPreferences.getToken;
      if (token.isEmpty) {
        emit(FavoriteError(message: 'User not authenticated'));
        return;
      }

      final response = await _dio.get(
        Urls.getFavorite,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final favoriteResponse = FavoriteResponse.fromJson(response.data);
        emit(FavoriteLoded(products: favoriteResponse.data.products));
      } else {
        emit(FavoriteError(message: 'Something went wrong'));
      }
    } catch (e) {
      emit(FavoriteError(message: e.toString()));
    }
  }
  Future<void> deleteFavorite(int id) async {
  emit(FavoriteLoding());

  final token = await AppSharedPreferences.getToken;
  if (token.isEmpty) {
    emit(FavoriteError(message: 'User is not authenticated'));
    return;
  }

  try {
    final response = await _dio.delete(
      Urls.deletFavorite(id),
      data: {'product_id': id},
      options: Options(headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      }),
    );

    if (response.statusCode == 200 && response.data['successful'] == true) {
      favoriteIds.remove(id);
      await _saveFavorites();
      emit(FavoriteActionDone(isAdded: false));
    } else {
      emit(FavoriteError(message: response.data['message'] ?? 'حدث خطأ أثناء الحذف'));
    }
  } catch (e) {
    emit(FavoriteError(message: "فشل الاتصال بالخادم: $e"));
  }
}

}
