// هنا انا بعمل class اسمه Failure في ال core layer وبعمله subclasses بترثه ومخصصة لكل نوع من ال failure اللي ممكن يحصل في ال api response بتاعتي زي network failure او server failure او cache failure
// ال class دا هستخدمه في ال repository بتاعي عشان احدد ال return type بتاع ال method اللي بتتعامل مع ال api اللي هي الشاشة دي هتتعامل معاها اللي هما featured books و best seller books
// هحدد ال errors اللي هتظهرلي في التطبيق في المستقبل فلما ي المستقبل يحصل error في ال api response هحدد ال errors هنا ك subclasses
abstract class Failure {
  final String errorMessage;

  Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);
}

// class CacheFailure extends Failure {
//   CacheFailure(super.errorMessage);
// }

// class NetworkFailure extends Failure {
//   NetworkFailure(super.errorMessage);
// }

// class EmptyServerFailure extends Failure {
//   EmptyServerFailure(super.errorMessage);
// }

// class EmptyCacheFailure extends Failure {
//   EmptyCacheFailure(super.errorMessage);
// }

// class EmptyNetworkFailure extends Failure {
//   EmptyNetworkFailure(super.errorMessage);
// }