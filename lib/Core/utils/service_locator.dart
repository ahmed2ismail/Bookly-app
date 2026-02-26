/*
- المشكلة اللي عندنا دلوقتي في الكود بتاعنا هو إن كل cubit بيعمل instance جديد من ال HomeRepoImplementaion و ال ApiService و ال Dio، وده مش efficient خالص، المفروض نعمل instance واحد من ال HomeRepoImplementaion و ال ApiService و ال Dio ونستخدمهم في كل مكان في ال app بتاعتنا عن طريق ال dependency injection، ودا هيحللنا مشاكل تكرار ال code وان كل cubit بيعمل instance جديد من ال HomeRepoImplementaion و ال ApiService و ال Dio، وده هيخلي ال code بتاعنا cleaner و more efficient، وبيسهل علينا اننا نعدل في ال dependencies دي لما نيجي نعدل في ال app بتاعتنا
- ال dependency injection هي طريقة لادارة ال dependencies بتاعتنا في ال app بتاعتنا، وبتساعدنا اننا نعمل instance واحد من ال dependencies دي ونستخدمها في كل مكان في ال app بتاعتنا، ودا بيخلي ال code بتاعنا cleaner و more efficient، وبيسهل علينا اننا نعدل في ال dependencies دي لما نيجي نعدل في ال app بتاعتنا
- ال get_it package(service locator) هو singleton pattern زي اللي في ال shared preferences، يعني
return MultiBlocProvider(
      providers: [
      BlocProvider(create: (context) => FeaturedBooksCubit(homeRepo: HomeRepoImplementaion(ApiService(Dio())))),
      BlocProvider(create: (context) => NewestBooksCubit(homeRepo: HomeRepoImplementaion(ApiService(Dio())))),
      احنا عندنا هنا مشاكل كتير بالشكل دا لان احنا بنعمل instance جديد من ال HomeRepoImplementaion في كل cubit، ودا مش efficient خالص، المفروض نعمل instance واحد من ال HomeRepoImplementaion ونستخدمه في الاتنين cubit، عشان كدا بنستخدم ال dependency injection عن طريق ال get_it package، ودا هيحللنا مشاكل تكرار ال code وان كل cubit بيعمل instance جديد من ال HomeRepoImplementaion، ApiService، و Dio وبعد كده لما نيجي نعدل  يبقي التعديل دا هيتطبف في كله مرة واحدة
      ال dependency injection هي طريقة لادارة ال dependencies بتاعتنا في ال app بتاعتنا، وبتساعدنا اننا نعمل instance واحد من ال dependencies دي ونستخدمها في كل مكان في ال app بتاعتنا، ودا بيخلي ال code بتاعنا cleaner و more efficient، وبيسهل علينا اننا نعدل في ال dependencies دي لما نيجي نعدل في ال app بتاعتنا
      ال get_it package(service locator) هو singleton pattern زي اللي في ال shared preferences، يعني بنعمل instance واحد من ال get_it و بنستخدمه في كل مكان في ال app
      فهنروح نعمل ملف جديد اسمه service_locator.dart في ال core/utils وهنعمل فيه instance واحد من ال HomeRepoImplementaion و ال ApiService و ال Dio ونستخدمهم في كل مكان في ال app بتاعتنا عن طريق ال get_it package
      ],
// هستخدم ال get_it package عشان اعمل instance واحد من ال HomeRepoImplementaion و ال ApiService و ال Dio ونستخدمهم في كل مكان في ال app بتاعتنا عن طريق ال get_it package
*/

import 'package:bookly_app/Core/utils/api_service.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo_implementaion.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// بنعرف متغير ثابت (global) هو اللي هنستخدمه في كل التطبيق عشان نوصل للأدوات بتاعتنا
final getIt = GetIt.instance;

void setupServiceLocator() {
  // 1. تسجيل الـ ApiService:
  // بنعمله هنا عشان الـ HomeRepoImpl بيعتمد عليه
  getIt.registerSingleton<ApiService>(ApiService(Dio()));

  // 2. تسجيل الـ HomeRepoImpl:
  // استخدمنا registerSingleton عشان نضمن إن الـ Repository ده يتنشئ منه نسخة واحدة بس
  // في الذاكرة طول ما التطبيق شغال، وده بيوفر جداً في الأداء وجهازك هيستريح
  getIt.registerSingleton<HomeRepoImpl>(
    HomeRepoImpl(
      getIt
          .get<
            ApiService
          >(), // هنا get_it بتدور على الـ ApiService اللي سجلناه فوق وبتبعته لـ HomeRepoImpl
    ),
  );
}

/*
🚀 إزاي تستخدمه في الـ main.dart؟
عشان الـ get_it يبدأ يشتغل لازم تنادي دالة الـ setupServiceLocator في أول الـ main:
void main() {
  setupServiceLocator(); // لازم تناديها قبل الـ runApp
  runApp(const BooklyApp());
}
*/
