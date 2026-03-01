import 'dart:ui';
import 'package:bookly_app/Core/widgets/custom_error_widget.dart';
import 'package:bookly_app/Core/widgets/books_shimmer_loading.dart';
import 'package:bookly_app/Features/home/presentation/manager/Featured_Books_Cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/Newest_Books_Cubit/newest_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FuturedBooksListView extends StatelessWidget {
  const FuturedBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeaturedBooksCubit, FeaturedBooksState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          // transitionBuilder: (child, animation) =>
              // FadeTransition(opacity: animation, child: child),
          duration: const Duration(milliseconds: 500), // وقت الأنميشن
          child: _buildAnimatedWidget(state, context),
        );
      },
    );
  }

  Widget _buildAnimatedWidget(FeaturedBooksState state, BuildContext context) {
    if (state is FeaturedBooksSuccess) {
      return SizedBox(
        key: const ValueKey('success'),
        height: MediaQuery.of(context).size.height * 0.3,
        // ال AspectRatio هتظبط ابعاد الصورة علي اساس ابعاد ال SizedBox والصورة هتبقي Responsible و مظبوطة علي اي جهاز
        child: ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
              PointerDeviceKind.trackpad,
            },
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.books.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CustomBookImage(
                imageUrl: state.books[index].volumeInfo.imageLinks?.thumbnail ?? '',
              ),
            ),
          ),
        ),
      );
    } else if (state is FeaturedBooksFailure) {
      return CustomErrorWidget(
        key: const ValueKey('failure'),
        errMessage: state.errMessage,
        onPressed: () {
          // عشان ن refresh البيانات من جديد لكل الاخبار اللي في الشاشة في حال لو المشكلة اتحلت
          BlocProvider.of<FeaturedBooksCubit>(context).fetchFeaturedBooks();
          BlocProvider.of<NewestBooksCubit>(context).fetchNewestBooks();
        },
      );
    } else {
      return const BooksShimmerLoading(
        key: ValueKey('loading'),
        type: ShimmerType.featured,
      );
    }
  }
}
