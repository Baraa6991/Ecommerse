import 'package:ecommerce/core/Apis/Urls.dart';
import 'package:ecommerce/core/SharedPreferences/SharedPreferencesHelper.dart';
import 'package:ecommerce/presentation/cubits/home/Archev/ArchevState.dart';
import 'package:ecommerce/presentation/models/ArchevModle.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class ArchivedCartCubit extends Cubit<ArchivedCartState> {
  ArchivedCartCubit() : super(ArchivedCartInitial());

  Future<void> fetchArchivedCartItems({int page = 1}) async {
    emit(ArchivedCartLoading());

    try {
      print("🔄 Fetching stores from: ${Urls.archive}");

      final token = await AppSharedPreferences.getToken;
      final response = await Dio().get(
        Urls.archive,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );
      print("✅ Response status code: ${response.statusCode}");
      if (response.statusCode == 200 && response.data['successful'] == true) {
        final List data = response.data['data']['Cart_items']['grouped_items'];

        final archivedItems =
            data.map((e) => ArchivedCartItemModel.fromJson(e)).toList();

        emit(ArchivedCartSuccess(archivedItems));
      } else {
        emit(ArchivedCartError(response.data['message'] ?? 'Unknown error'));
      }
    } catch (e) {
      emit(ArchivedCartError('حدث خطأ أثناء تحميل الفواتير القديمة'));
    }
  }
}
