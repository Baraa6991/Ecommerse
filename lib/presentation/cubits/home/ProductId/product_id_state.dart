part of 'product_id_cubit.dart';

@immutable
sealed class ProductIdState {}

final class ProductIdInitial extends ProductIdState {}
final class ProductIdLoding extends ProductIdState {}
final class ProductIdLoded extends ProductIdState {
  final StoreResponsess storeResponsess;

  ProductIdLoded({required this.storeResponsess});
}
final class ProductIdError extends ProductIdState {
  final String massage;

  ProductIdError({required this.massage});
}
