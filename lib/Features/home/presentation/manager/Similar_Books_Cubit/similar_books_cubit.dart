import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly_app/Features/home/data/repos/home_repository.dart';
import 'package:meta/meta.dart';

part 'similar_books_cubit_state.dart';

class SimilarBooksCubit extends Cubit<SimilarBooksCubitState> {
  SimilarBooksCubit({required this.homeRepo}) : super(SimilarBooksCubitInitial());

  final HomeRepo homeRepo;

  Future<void> fetchSimilarBooks({required String category}) async {
    emit(SimilarBooksCubitLoading());
    await Future.delayed(const Duration(seconds: 1));
    var result = await homeRepo.fetchSimilarBooks(category: category);
    result.fold(
      (failure) => emit(SimilarBooksCubitFailure(failure.errMessage)),
      (books) => emit(SimilarBooksCubitSuccess(books)),
    );
  }
}
