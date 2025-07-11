
import 'package:ecommerce/presentation/models/modleProducts.dart';

import 'package:meta/meta.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Product> products;
  SearchLoaded({required this.products});
}

class SearchError extends SearchState {
  final String message;
  SearchError({required this.message});
}
