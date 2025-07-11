part of 'category_cubit.dart';

@immutable
sealed class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class CategoryLoding extends CategoryState {}

final class CategoryLoded extends CategoryState {
  final CategoryResponse categoryResponse;

  CategoryLoded({required this.categoryResponse});
}

final class CategoryError extends CategoryState {
  final String massage;

  CategoryError({required this.massage});
}
