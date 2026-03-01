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
    ); // انا هنا بعمل emit لل loading state عشان اعرض ال shimmer scene في ال ui بتاعي لحد ما يخلص ال api call بتاعتي
    /*
    مشكلة "تجربة المستخدم" (UX) مشهورة جداً اسمها الـ UI Flickering أو الومضة.
    المشكلة دي بتحصل لأن مكتبة Dio وجهازك الـ HP EliteBook سراع جداً في اكتشاف إن "مفيش نت"؛ فبمجرد ما الـ Cubit بيبدأ، بيعمل emit(Loading) (الـ Shimmer يظهر)، وفي أقل من أجزاء من الثانية الـ API بيطلع Error فبيعمل emit(Failure) (الـ Error يظهر). النتيجة إن العين بتشوف "رعشة" سريعة للـ Shimmer
    بنضيف تأخير ثانية واحدة عشان الـ Shimmer يلحق يظهر
    */
    await Future.delayed(const Duration(seconds: 1));
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
