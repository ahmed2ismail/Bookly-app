// هنا هنستخدم ال repository pattern عشان نفصل بين ال data layer و ال presentation layer
// ال repository pattern بيعتمد علي ان انا انشئ abstract class وجوه ال abstract class دا انا بعمل ال methods وخلاص بدون ما اعمل اي implementation لل methods
// في ال repository pattern انا بقول ال method دي هتعمل ايه بس من غير ما اقولها هتعمله ازاي لان انا ممكن يكون عندي اكتر من طريقة لتنفيذ الحاجة دي يعني ممكن يكون عندي api مختلفة او ممكن يكون عندي local database فانا بقول ال method دي هتعمل ايه بس من غير ما اقولها هتعمله ازاي عشان لو انا حبيت اغير ال implementation بتاع ال method دي في المستقبل مش هيأثر علي ال presentation layer خالص
// ال repository pattern بيخليني يبقي عندي نظرة عامة عن ال Future دي بتعمل اي
import 'package:bookly_app/Core/errors/failures.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
// هنا احنا بنعرف ال repository اللي بيحتوي علي الدوال اللي بتتعامل مع ال api
// كل method في ال repository دي بتكون مسؤولة عن جلب نوع معين من البيانات من ال api اللي هي الشاشة دي هتتعامل معاها اللي هما featured books و best seller books
// يعني من الاخر انا بعمل abstract class وبعمل جواه ال methods اللي بتتعامل مع ال api اللي هي الشاشة دي هتتعامل معاها اللي هما featured books و best seller books
// ال return type بتاع ال method دي لازم ترجع حاجة في حالة ال success و حاجة في حالة ال failure عشان انا ممكن يكون عندي اكتر من حالة في ال api response بتاعتي يعني ممكن يكون عندي حالة ال success اللي هي بترجعلي البيانات اللي انا عايزها و ممكن يكون عندي حالة ال failure اللي هي بترجعلي error message او exception عشان انا اقدر اعمل handle لل error في ال presentation layer
// عشان كدا انا بستخدم ال Either class من ال dartz package اللي بتخليني ارجع حاجة في حالة ال success و حاجة في حالة ال failure في نفس الوقت يعني انا بقول ال method دي هترجعلي يا اما بيانات من نوع List<BooksModel> في حالة ال success يا اما error message او exception في حالة ال failure
// ال Either (إما , أو) دي بتاخد نوعين من ال types يعني انا بقول ال method دي هترجعلي يا اما String في حالة ال failure يا اما List<BooksModel> في حالة ال success
// Either<L, R> --> L هو نوع ال failure و R هو نوع ال success
// انا عندي انواع كتيرة من ال failure ممكن يكون عندي network failure او server failure او cache failure فانا بقول ال method دي هترجعلي class هنعمله مخصوص لكل حالات ال failure دي عشان اقدر اعمل handle لل error في ال presentation layer بشكل افضل وهنعمل ال class دا في ال core layer عشان اقدر استخدمه في كل ال features بتاعتي
// عشان كدا انا بعمل class اسمه Failure في ال core layer وبعمله subclasses لكل نوع من ال failure اللي ممكن يحصل في ال api response بتاعتي زي network failure او server failure او cache failure وانا بقول ال method دي هترجعلي يا اما class من نوع Failure في حالة ال failure يا اما List<BooksModel> في حالة ال success
// كدا احنا حددنا ال return type بتاع ال method ولو فيه arguments احنا محتاجينها فلازم تبعتها لل method دي عشان تنفذ ال api call بتاعتها زي مثلا لو انا عايز اعمل pagination في ال api call بتاعتي فانا بقول ال method دي لازم تبعتلي page number عشان اقدر اعمل pagination في ال api call بتاعتي
  Future<Either<Failure, List<BooksModel>>> fetchFeaturedBooks();
  Future<Either<Failure, List<BooksModel>>> fetchBestSellerBooks();
}