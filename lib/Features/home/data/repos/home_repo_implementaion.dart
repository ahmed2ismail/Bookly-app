import 'package:bookly_app/Features/home/data/repos/home_repository.dart';
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
  @override
  Future fetchBestSellerBooks() {
    // TODO: implement fetchBestSellerBooks
    throw UnimplementedError();
  }

  @override
  Future fetchFeaturedBooks() {
    // TODO: implement fetchFeaturedBooks
    throw UnimplementedError();
  }
  
}