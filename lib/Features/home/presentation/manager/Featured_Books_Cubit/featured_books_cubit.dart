import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:meta/meta.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit() : super(FeaturedBooksInitial());
}
