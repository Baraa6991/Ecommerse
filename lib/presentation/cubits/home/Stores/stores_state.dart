import 'package:ecommerce/presentation/models/modelStores.dart';


abstract class StoreState {}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final StoreResponse storeResponse;

  StoreLoaded(this.storeResponse);
}

class StoreError extends StoreState {
  final String message;

  StoreError(this.message);
}
