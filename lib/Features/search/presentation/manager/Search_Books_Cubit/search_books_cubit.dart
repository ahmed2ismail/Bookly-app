import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly_app/Features/search/data/SearchRepo/search_repo.dart';
import 'package:meta/meta.dart';

part 'search_books_state.dart';

class SearchBooksCubit extends Cubit<SearchBooksState> {
  SearchBooksCubit({required this.searchRepo}) : super(SearchCubitInitial());

  final SearchRepo searchRepo;
  Future<void> fetchSearchBooks({required String bookName}) async {
    emit(SearchCubitLoading());
    if (isClosed) return; // لو ال Cubit اتقفل ما نكملش تنفيذ الكود
    var result = await searchRepo.fetchSearchBooks(bookName: bookName);
    result.fold(
      (failure) => emit(SearchCubitFailure(failure.errMessage)),
      (books) => emit(SearchCubitSuccess(books)),
    );
  }
}
