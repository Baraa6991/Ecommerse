part of 'stores_with_id_cubit.dart';

@immutable
sealed class StoresWithIdState {}

final class StoresWithIdInitial extends StoresWithIdState {}

final class StoresWithIdLoded extends StoresWithIdState {
  final CategoryDetailsResponse categoryResponse;

  StoresWithIdLoded({required this.categoryResponse});
}

final class StoresWithIdLoding extends StoresWithIdState {}

final class StoresWithIdError extends StoresWithIdState {
  final String masage;

  StoresWithIdError({required this.masage});
}
