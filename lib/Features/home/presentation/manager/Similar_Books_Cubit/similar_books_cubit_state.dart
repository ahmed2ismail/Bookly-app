part of 'similar_books_cubit.dart';

@immutable
sealed class SimilarBooksCubitState {}

final class SimilarBooksCubitInitial extends SimilarBooksCubitState {}

final class SimilarBooksCubitLoading extends SimilarBooksCubitState {}

final class SimilarBooksCubitSuccess extends SimilarBooksCubitState {
  final List<BooksModel> books;
  SimilarBooksCubitSuccess(this.books);
}

final class SimilarBooksCubitFailure extends SimilarBooksCubitState {
  final String errMessage;
  SimilarBooksCubitFailure(this.errMessage);
}
