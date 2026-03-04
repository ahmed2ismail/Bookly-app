import 'package:bookly_app/Core/utils/styles.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/newest_books_list_view.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_appbar.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/featured_books_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // CustomScrollView widget بنستخدمها عشان نعمل nested ListView بداخلها
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppBar(),
              const FuturedBooksListView(),
              SizedBox(height: 50.h),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text('Newest Books', style: Styles.textStyle18),
              ),
            ],
          ),
        ),
        const SliverToBoxAdapter(child: NewestBooksListView()),
        // SliverFillRemaining : بتستخدم عشان تخلي ال ListView اللي جواها تاخد المساحة المتبقية من ال screen وتتعامل معاها كأنها جزء واحد من ال scroll، وبكده حلينا مشكلة ال scrolling جوا ال ListView اللي كانت بتعارض ال CustomScrollView.
      ],
    );
  }
}
