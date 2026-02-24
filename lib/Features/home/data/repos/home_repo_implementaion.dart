import 'package:bookly_app/Core/errors/failures.dart';
import 'package:bookly_app/Core/utils/api_service.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly_app/Features/home/data/repos/home_repository.dart';
import 'package:dartz/dartz.dart';

// implementation of the home repository
// implement عشان انا عايز اعمل implementation لل home repository عشان يعمل كل اللي انا عايزه من ال api call اللي هي الشاشة دي هتتعامل معاها اللي هما featured books و best seller books او اي حاجة انا حددتهاله في ال home repository
class HomeRepoImplementaion implements HomeRepo {
  // انا فرضت عليه قاعدة ان هو يعمل implementation لكل ال methods اللي انا حددتهاله في ال home repository عشان كدا انا عملت override لكل ال methods
  // بعد كده انا هحدد انا هعمل ال request ب ايه يا اما ب dio package او ب http package وانا بحب ال dio package اكتر عشان هو بيحتوي علي مميزات كتيرة زي ال interceptors و ال global configuration و ال form data و ال file downloading و ال file uploading و ال request cancellation و ال timeout و غيرها كتير من المميزات اللي بتسهل عليا التعامل مع ال api call بتاعتي
  // ال dio package بيخليني اعمل request بطرق كتيرة زي ال get و ال post و ال put و ال delete و غيرها كتير من الطرق اللي بتسهل عليا التعامل مع ال api call بتاعتي
  // ال dio package كمان افضل في رفع الملفات
  // هنا لازم نوحد المصدر بتاع ال get request بتاعنا عشان لو حبيت اي حاجة بعدين اغيرها من مكان واحد وتتغير معايا في كل الاماكن
  // فهنعمل wrapper اللي هي نقطة تواصل مبين ال service بتاعتي والنقطة دي هي اللي بتتعامل في كل الاماكن ومع ال سيرفس بتاعتي وانا بتعامل مع النقطة دي
  // فهروح اعمل class اسمه ApiService في ال core/utils layer وهعمل فيه ال get request بتاعي و ال post request بتاعي و ال put request بتاعي و ال delete request بتاعي و اي حاجة انا محتاجها في ال api call بتاعتي زي ال headers و ال query parameters و غيرها كتير من الحاجات اللي بتسهل عليا التعامل مع ال api call بتاعتي
  final ApiService
  apiService; // انا هنا بعمل instance من ال ApiService عشان اقدر استخدمه في ال methods اللي هعملها في ال home repository implementation عشان اعمل ال api call بتاعتي لل features دول featured books و best seller books
  HomeRepoImplementaion(this.apiService);

  @override
  Future<Either<Failure, List<BooksModel>>> fetchNewestBooks() async {
    try {
      var data = await apiService.get(
        endpoint:
            'volumes?q=subject:Programming&Filtering=free-ebooks&Sorting=newest',
      );
      // ال data اللي جالي من ال api call بتاعتي بيكون في شكل json format اللي هي ال map الكبيرة خالص وانا طبعا عايز اوصل لل "items" اللي جواها فانا لازم اعمل parsing لل data دي عشان اقدر احولها ل objects من نوع BooksModel
      // انا هنا بعمل parsing لل data اللي جالي من ال api call بتاعتي عشان اقدر احولها من ال json format اللي جالي بيه من ال api call بتاعتي ل objects من نوع BooksModel اللي انا عملته في ال data layer بتاعي عشان اقدر استخدمه في ال presentation layer بتاعي
      List<BooksModel> books = [];
      for (var item in data['items']) {
        books.add(BooksModel.fromJson(item));
      }
      return Right(books);
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    } catch (e) {
      throw Exception('Failed to fetch newest books: $e');
    }
  }

  @override
  Future<Either<Failure, List<BooksModel>>> fetchFeaturedBooks() {
    // TODO: implement fetchFeaturedBooks
    throw UnimplementedError();
  }
}
