import 'package:bookly_app/Core/widgets/custom_error_widget.dart';
import 'package:bookly_app/Core/widgets/books_shimmer_loading.dart';
import 'package:bookly_app/Features/home/presentation/manager/Featured_Books_Cubit/featured_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/manager/Newest_Books_Cubit/newest_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewestBooksListView extends StatelessWidget {
  const NewestBooksListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewestBooksCubit, NewestBooksState>(
      builder: (context, state) {
        return AnimatedSwitcher(
          // AnimatedSwitcher: بتعمل "Fade" أو انتقال ناعم بين الـ Widgets لما الحالة تتغير، بدل ما الشاشة "تخطف" فجأة من الـ Shimmer للـ Success
          // transitionBuilder: (child, animation) =>
              // FadeTransition(opacity: animation, child: child), --> دا ال default transition
          duration: const Duration(milliseconds: 500), // وقت الأنميشن
          child: _buildAnimatedWidget(state, context),
        );
      },
    );
  }

  // دالة لفصل الـ Logic وتسهيل القراءة
  StatelessWidget _buildAnimatedWidget(
    NewestBooksState state,
    BuildContext context,
  ) {
    if (state is NewestBooksSuccess) {
      return ListView.builder(
        // المفتاح دا هو اللي بيقول لل AnimatedSwitcher الحالة دي ليها ويدجت خاصة بيها فهتعرضها مع ال الانميشن ولو نقل علي state تانية فبرده المفتاح بتاع ال state التانية بيقولها انك هتعرضي ويدجت مختلفة فمتعمليش refresh للويدجت اللي فاتت واعتبري ان هي خلصت واعرضي الويدجت بتاعتي مع الانميشن وهكذا
        key: const ValueKey('success'), // المفتاح ده ضروري عشان الأنميشن يشتغل
        shrinkWrap: true,
        physics:
            const NeverScrollableScrollPhysics(), // بمعني ميبقاش فيه scroll خالص
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: BookListViewItem(booksModel: state.books[index]),
        ),
        itemCount: state.books.length,
      );
    } else if (state is NewestBooksFailure) {
      return CustomErrorWidget(
        key: const ValueKey('failure'), // مفتاح فريد لحالة الخطأ
        errMessage: state.errMessage,
        onPressed: () {
          BlocProvider.of<FeaturedBooksCubit>(context).fetchFeaturedBooks();
          BlocProvider.of<NewestBooksCubit>(context).fetchNewestBooks();
        },
      );
    } else {
      return const BooksShimmerLoading(
        key: ValueKey('loading'), // مفتاح فريد للـ Shimmer
        type: ShimmerType.newest,
      );
    }
  }
}
