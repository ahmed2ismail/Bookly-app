import 'dart:ui';
import 'package:bookly_app/Core/widgets/books_shimmer_loading.dart';
import 'package:bookly_app/Core/widgets/custom_error_widget.dart';
import 'package:bookly_app/Features/home/presentation/manager/Similar_Books_Cubit/similar_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimilarBooksListView extends StatelessWidget {
  const SimilarBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SimilarBooksCubit, SimilarBooksCubitState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _buildAnimatedWidget(state, context),
        );
      },
    );
  }

  Widget _buildAnimatedWidget(SimilarBooksCubitState state, BuildContext context) {
    if (state is SimilarBooksCubitSuccess) {
      return SizedBox(
        key: const ValueKey('success'),
        height: MediaQuery.of(context).size.height * 0.15,
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
            itemCount: 20,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: CustomBookImage(
                imageUrl:
                    'https://www.pexels.com/photo/assorted-dvd-case-lot-on-shelves-276005/',
              ),
            ),
          ),
        ),
      );
    } else if (state is SimilarBooksCubitFailure) {
      return CustomErrorWidget(
        key: const ValueKey('failure'), // مفتاح فريد لحالة الخطأ
        errMessage: state.errMessage,
        onPressed: () {
          BlocProvider.of<SimilarBooksCubit>(context).fetchSimilarBooks(category: 'Programming');
        },
      );
    } else {
      return const BooksShimmerLoading(
        key: ValueKey('loading'), // مفتاح فريد للـ Shimmer
        type: ShimmerType.similar,
      );
    }
  }
}
