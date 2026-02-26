import 'package:bloc/bloc.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly_app/Features/home/data/repos/home_repository.dart';
import 'package:meta/meta.dart';
part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit({required this.homeRepo}) : super(FeaturedBooksInitial());

  final HomeRepo
  homeRepo; // انا هنا بعمل instance من ال home repository عشان اقدر استخدمه في استدعاء ال methods

  Future<void> fetchFeaturedBooks() async {
    emit(
      FeaturedBooksLoading(),
    ); // انا هنا بعمل emit لل loading state عشان اعرض ال loading indicator في ال ui بتاعي لحد ما يخلص ال api call بتاعتي
    var result = await homeRepo
        .fetchFeaturedBooks(); // انا هنا بعمل استدعاء لل method اللي جوا ال home repository عشان اعمل ال api call بتاعتي لل featured books
    result.fold(
      (failure) => emit(
        FeaturedBooksFailure(failure.errMessage),
      ), // لو حصل failure في ال api call بتاعتي بعمل emit لل failure state وببعتلي رسالة الخطأ اللي جالي من ال failure عشان اعرضها في ال ui بتاعي
      (books) => emit(
        FeaturedBooksSuccess(books),
      ), // لو حصل success في ال api call بتاعتي بعمل emit لل success state وببعتلي البيانات اللي جالي من ال api call بتاعتي عشان اعرضها في ال ui بتاعي
    );
  }
}
