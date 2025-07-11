import 'package:ecommerce/presentation/models/modleCart.dart';

sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoding extends CartState {}

final class CartLoded extends CartState {}

final class CartLodedGet extends CartState {
  final CartResponse cartItemResponse;

  CartLodedGet({required this.cartItemResponse});
}

final class CartError extends CartState {
  final String massege;

  CartError({required this.massege});
}
