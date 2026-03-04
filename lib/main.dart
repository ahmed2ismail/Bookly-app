import 'package:bookly_app/Core/utils/app_router.dart';
import 'package:bookly_app/Core/utils/service_locator.dart';
import 'package:bookly_app/Features/home/data/repos/home_repo_implementaion.dart';
import 'package:bookly_app/Features/home/presentation/manager/Featured_Books_Cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/Newest_Books_Cubit/newest_books_cubit.dart';
import 'package:bookly_app/constants.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupServiceLocator(); // تهيئة الـ GetIt قبل تشغيل التطبيق و لازم نناديها قبل الـ runApp
  runApp(
    DevicePreview(
      enabled:
          true, // بنشغله بس وقت التطوير عشان نقدر نشوف التطبيق علي كل الأجهزة
      builder: (context) => const BooklyApp(),
    ),
  );
}

class BooklyApp extends StatelessWidget {
  const BooklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FeaturedBooksCubit(
            homeRepo: getIt
                .get<HomeRepoImpl>(), // هنا بنسحب الـ instance الجاهز من get_it
          )..fetchFeaturedBooks(), // // الـ .. دي اسمها Cascade Notation في لغة Dart
          // بتسمح لك تنفذ كود (Method) على الـ Object اللي لسه عامله create حالا من غير ما تضطر تخزنه في variable
          // هنا بنقول له: بعد ما تعمل create للـ FeaturedBooksCubit، نادي فوراً على function الـ fetchFeaturedBooks عشان يبدأ يحمل البيانات أول ما التطبيق يفتح
          // واحنا عملنا كده عشان منحطش ال request بتاعنا جوه stateFulWidget في init state
        ),
        BlocProvider(
          create: (context) => NewestBooksCubit(
            homeRepo: getIt
                .get<HomeRepoImpl>(), // نفس الكلام للـ NewestBooksCubit
          )..fetchNewestBooks(), // استدعيلي ال method دي ونفذهالي مباشرة بعد متعمل ال cubit
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812), // مقاس تصميم Figma الشائع و ضبط مقاسات التصميم الأصلية
        minTextAdapt: true, // عشان الخط يتناسب مع كل الشاشات
        splitScreenMode:
            true, // عشان لو الشاشة كبيرة (زي التابلت) يوزع المحتوى بشكل أفضل
        builder: (context, child) {
          return MaterialApp.router(
            // ضبط الـ Locale والـ Builder ليعمل مع DevicePreview
            locale: DevicePreview.locale(context),
            builder: (context, child) {
              // 1. تشغيل الـ DevicePreview أولاً
              child = DevicePreview.appBuilder(context, child);
              
              // 2. تغليف التطبيق بـ MediaQuery لتثبيت حجم الخط
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  // إجبار الخط على الثبات عند معامل 1.0 لمنع الـ Overflow
                  textScaler: const TextScaler.linear(1.0), 
                ),
                child: child,
              );
            },
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            title: 'Bookly App',
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: kPrimaryColor,
              textTheme: GoogleFonts.montserratTextTheme(
                ThemeData.dark().textTheme,
              ),
            ),
          );
        },
      ),
    );
  }
}
