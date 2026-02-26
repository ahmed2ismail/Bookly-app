part of 'featured_books_cubit.dart';

@immutable
sealed class FeaturedBooksState {}

final class FeaturedBooksInitial extends FeaturedBooksState {}

final class FeaturedBooksLoading extends FeaturedBooksState {}

final class FeaturedBooksSuccess extends FeaturedBooksState {
  // انا بعتمد علي نقطة انا هستقبل البيانات فين وبحدد هل انا هستقبل البيانات هنا جوه ال success state ولا هخليها في ال cubit وانا هنا قررت اني هستقبل البيانات جوه ال state عشان اقدر اعرضها في ال list view مباشرة
  final List<BooksModel> books;
  FeaturedBooksSuccess(this.books);
}

final class FeaturedBooksFailure extends FeaturedBooksState {
  final String errorMessage;
  FeaturedBooksFailure(this.errorMessage);
}