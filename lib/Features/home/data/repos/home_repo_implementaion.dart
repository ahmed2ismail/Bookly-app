import 'package:bookly_app/Core/errors/failures.dart';
import 'package:bookly_app/Core/utils/api_service.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly_app/Features/home/data/repos/home_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// implementation(Impl) of the home repository
// implement عشان انا عايز اعمل implementation لل home repository عشان يعمل كل اللي انا عايزه من ال api call اللي هي الشاشة دي هتتعامل معاها اللي هما featured books و best seller books او اي حاجة انا حددتهاله في ال home repository
class HomeRepoImpl implements HomeRepo {
  // انا فرضت عليه قاعدة ان هو يعمل implementation لكل ال methods اللي انا حددتهاله في ال home repository عشان كدا انا عملت override لكل ال methods
  // بعد كده انا هحدد انا هعمل ال request ب ايه يا اما ب dio package او ب http package وانا بحب ال dio package اكتر عشان هو بيحتوي علي مميزات كتيرة زي ال interceptors و ال global configuration و ال form data و ال file downloading و ال file uploading و ال request cancellation و ال timeout و غيرها كتير من المميزات اللي بتسهل عليا التعامل مع ال api call بتاعتي
  // ال dio package بيخليني اعمل request بطرق كتيرة زي ال get و ال post و ال put و ال delete و غيرها كتير من الطرق اللي بتسهل عليا التعامل مع ال api call بتاعتي
  // ال dio package كمان افضل في رفع الملفات
  // هنا لازم نوحد المصدر بتاع ال get request بتاعنا عشان لو حبيت اي حاجة بعدين اغيرها من مكان واحد وتتغير معايا في كل الاماكن
  // فهنعمل wrapper اللي هي نقطة تواصل مبين ال service بتاعتي والنقطة دي هي اللي بتتعامل في كل الاماكن ومع ال سيرفس بتاعتي وانا بتعامل مع النقطة دي
  // فهروح اعمل class اسمه ApiService في ال core/utils layer وهعمل فيه ال get request بتاعي و ال post request بتاعي و ال put request بتاعي و ال delete request بتاعي و اي حاجة انا محتاجها في ال api call بتاعتي زي ال headers و ال query parameters و غيرها كتير من الحاجات اللي بتسهل عليا التعامل مع ال api call بتاعتي
  final ApiService
  apiService; // انا هنا بعمل instance من ال ApiService عشان اقدر استخدمه في ال methods اللي هعملها في ال home repository implementation عشان اعمل ال api call بتاعتي لل features دول featured books و best seller books
  HomeRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<BooksModel>>> fetchNewestBooks() async {
    try {
      // بننادي الـ API من خلال الـ ApiService اللي عملته في ال core/utils layer
      var data = await apiService.get(
        endpoint:
            'volumes?q=subject:Programming&Filtering=free-ebooks&Sorting=newest',
      );
      // ال data اللي جالي من ال api call بتاعتي بيكون في شكل json format اللي هي ال map الكبيرة خالص وانا طبعا عايز اوصل لل "items" اللي جواها فانا لازم اعمل parsing لل data دي عشان اقدر احولها ل objects من نوع BooksModel
      // انا هنا بعمل parsing لل data اللي جالي من ال api call بتاعتي عشان اقدر احولها من ال json format اللي جالي بيه من ال api call بتاعتي ل objects من نوع BooksModel اللي انا عملته في ال data layer بتاعي عشان اقدر استخدمه في ال presentation layer بتاعي
      List<BooksModel> books = [];
      for (var item in data['items']) {
        books.add(BooksModel.fromJson(item)); // JSON Parsing
      }
      return Right(books);
    } catch (e) {
      // لو الخطأ من Dio بنستخدم الـ factory اللي عملناه
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      // لو خطأ غير متوقع برمجياً بنرجع رسالة خطأ عامة
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BooksModel>>> fetchFeaturedBooks() async {
    // نفس المنطق بنطبقه هنا لجلب الكتب المختارة (featured books) من ال API بس بنغير ال endpoint اللي بنناديه عشان يجيبلي الكتب المخترة بدل الكتب الجديدة
    try {
      var data = await apiService.get(
        endpoint: 'volumes?Filtering=free-ebooks&q=subject:Programming',
      );
      List<BooksModel> books = [];
      for (var item in data['items']) {
        books.add(BooksModel.fromJson(item));
      }
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}

// وكدا احنا خلصنا ال Data Layer بتاعتي لل home feature
// وكدا هنبدا نربط بين ال Data Layer بتاعتي وال Presentation Layer اللي فيها ال ui 
// وهي دي ال MVVM architecture اللي انا بتبعها في ال flutter project بتاعي ودي متقسمة ل view model وبعد كده بعدين ال view اللي هي ال ui :
// Model: هي المسؤولة عن تمثيل ال data اللي جايه من ال repository اللي هي ال data layer وبتحولها ل objects اللي ال view model بتحتاجها عشان تعرضها في ال ui
// View: جزء من ال presentation layer هي المسؤولة عن عرض ال data اللي جايه من ال view model في ال ui وبتتعامل مع ال user interactions زي ال button clicks و ال text input و غيرها كتير من ال user interactions اللي بتحدث في ال ui
// ViewModel: هي اللي بت manage ال state بتاع ال ui (view) وبتتعامل مع ال business logic --> bloc او provider او اي state management technique
// عشان كده ال MVVM architecture , Bloc الاتنين زي بعض بالظبط لانهم بي manage ال state بتاع ال ui وبيتعاملوا مع ال business logic بس الفرق بينهم ان ال Bloc بيستخدم ال events وال states عشان يدير ال state بتاع ال ui اما ال ViewModel بيستخدم ال properties وال methods عشان يدير ال state بتاع ال ui
// يعني جوه ال presentation layer بتاعتي انا ممكن اعمل view model folder و اعمل فيه ال view model بتاعتي اللي هي المسؤولة عن ال business logic و ال state management بتاع ال ui و بعد كده اعمل view folder و اعمل فيه ال ui بتاعتي اللي هي المسؤولة عن عرض ال data اللي جايه من ال view model في ال ui وبتتعامل مع ال user interactions زي ال button clicks و ال text input و غيرها كتير من ال user interactions اللي بتحدث في ال ui
// يعني ال view model دا ممكن يكون اي حاجة زي ال bloc او ال provider او getx controller لانه بيعبر عن حاجة ب manage بيها ال state بتاع ال ui
// بما انه متاح استخدم اي state management technique فانا هسميه manager عشان هو مش مرتبط بحاجة معينة زي ال bloc او ال provider او getx controller لانه بيعبر عن حاجة ب manage بيها ال state بتاع ال ui
// وكدا احنا خلصنا ال presentation layer بتاعتي لل home feature