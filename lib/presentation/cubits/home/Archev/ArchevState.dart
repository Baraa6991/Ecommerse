

import 'package:ecommerce/presentation/models/ArchevModle.dart';

abstract class ArchivedCartState {}

class ArchivedCartInitial extends ArchivedCartState {}
class ArchivedCartLoading extends ArchivedCartState {}
class ArchivedCartSuccess extends ArchivedCartState {
  final List<ArchivedCartItemModel> archivedItems;

  ArchivedCartSuccess(this.archivedItems);
}
class ArchivedCartError extends ArchivedCartState {
  final String message;

  ArchivedCartError(this.message);
}
