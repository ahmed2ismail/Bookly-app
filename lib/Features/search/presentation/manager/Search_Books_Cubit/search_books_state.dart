part of 'search_books_cubit.dart';

@immutable
sealed class SearchBooksState {}

final class SearchCubitInitial extends SearchBooksState {}

final class SearchCubitLoading extends SearchBooksState {}

final class SearchCubitSuccess extends SearchBooksState {
  final List<BooksModel> books;
  SearchCubitSuccess(this.books);
}

final class SearchCubitFailure extends SearchBooksState {
  final String errMessage;
  SearchCubitFailure(this.errMessage);
}
