part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoding extends ProductsState {}

final class ProductsLoded extends ProductsState {
  final ProductsResponse productsResponse;

  ProductsLoded({required this.productsResponse});
}

final class ProductsError extends ProductsState {
  final String masage;

  ProductsError({required this.masage});
}
