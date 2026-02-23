// هنا هنستخدم ال repository pattern عشان نفصل بين ال data layer و ال presentation layer
// ال repository pattern بيعتمد علي ان انا انشئ abstract class وجوه ال abstract class دا انا بعمل ال methods وخلاص بدون ما اعمل اي implementation لل methods
// في ال repository pattern انا بقول ال method دي هتعمل ايه بس من غير ما اقولها هتعمله ازاي لان انا ممكن يكون عندي اكتر من طريقة لتنفيذ الحاجة دي يعني ممكن يكون عندي api مختلفة او ممكن يكون عندي local database فانا بقول ال method دي هتعمل ايه بس من غير ما اقولها هتعمله ازاي عشان لو انا حبيت اغير ال implementation بتاع ال method دي في المستقبل مش هيأثر علي ال presentation layer خالص
// ال repository pattern بيخليني يبقي عندي نظرة عامة عن ال Future دي بتعمل اي
abstract class HomeRepo {
// هنا احنا بنعرف ال repository اللي بيحتوي علي الدوال اللي بتتعامل مع ال api
// كل method في ال repository دي بتكون مسؤولة عن جلب نوع معين من البيانات من ال api اللي هي الشاشة دي هتتعامل معاها اللي هما featured books و best seller books
// يعني من الاخر انا بعمل abstract class وبعمل جواه ال methods اللي بتتعامل مع ال api اللي هي الشاشة دي هتتعامل معاها اللي هما featured books و best seller books
  Future<List<String>> fetchFeaturedBooks();
  Future<List<String>> fetchBestSellerBooks();
}