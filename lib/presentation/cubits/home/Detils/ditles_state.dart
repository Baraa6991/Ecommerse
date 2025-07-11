part of 'ditles_cubit.dart';

@immutable
sealed class DitlesState {}

final class DitlesInitial extends DitlesState {}

final class DitlesLoded extends DitlesState {
  final ProductResponse productResponse;

  DitlesLoded({required this.productResponse});
}

final class DitlesLoding extends DitlesState {}

final class DitlesError extends DitlesState {
  final String massage;

  DitlesError({required this.massage});
}
