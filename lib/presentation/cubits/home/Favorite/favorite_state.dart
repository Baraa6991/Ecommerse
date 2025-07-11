part of 'favorite_cubit.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

final class FavoriteLoded extends FavoriteState {
  final List<FavoriteProduct> products;
  FavoriteLoded({required this.products});
}

final class FavoriteLoding extends FavoriteState {}

final class FavoriteError extends FavoriteState {
  final String message;
  FavoriteError({required this.message});
}

class FavoriteActionDone extends FavoriteState {
  final bool isAdded;
  FavoriteActionDone({required this.isAdded});
}
