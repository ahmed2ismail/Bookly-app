import 'package:bookly_app/Core/widgets/books_shimmer_loading.dart';
import 'package:bookly_app/Core/widgets/custom_error_widget.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_list_view_item.dart';
import 'package:bookly_app/Features/search/presentation/manager/Search_Books_Cubit/search_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({super.key, required this.searchController});

  // بنضيف الـ searchController هنا عشان نقدر نجيب النص منه وقت الـ retry
  final TextEditingController searchController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBooksCubit, SearchBooksState>(
      builder: (context, state) {
        // إضافة الـ AnimatedSwitcher عشان الانتقال ميبقاش "خبط لزق"
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: _buildSearchContent(context, state),
        );
      },
    );
  }

  // فصلنا الـ Logic في دالة لوحدها عشان الكود يفضل "Clean"
  Widget _buildSearchContent(BuildContext context, SearchBooksState state) {
    if (state is SearchCubitSuccess) {
      if (state.books.isEmpty) {
        return const Center(
          key: ValueKey(
            'empty',
          ), // الـ Key ضروري عشان الـ AnimatedSwitcher يشتغل صح
          child: Text('No books found, try another name.'),
        );
      }
      return ListView.builder(
        key: const ValueKey('success'),
        padding: EdgeInsets.zero,
        itemCount: state.books.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            // الـ Item الاحترافي اللي صلحنا فيه الـ Overflow
            child: BookListViewItem(booksModel: state.books[index]),
          );
        },
      );
    } else if (state is SearchCubitFailure) {
      return CustomErrorWidget(
        key: const ValueKey('failure'),
        errMessage: state.errMessage,
        // هنا الـ onPressed هينادي على البحث تاني بنفس الكلمة اللي في الـ TextField عشان لو حصلت مشكلة في النت مثلا يقدر يجرب تاني بسهولة
        onPressed: () {
          if (searchController.text.isNotEmpty) {
            BlocProvider.of<SearchBooksCubit>(
              context,
            ).fetchSearchBooks(bookName: searchController.text);
          }
        },
      );
    } else if (state is SearchCubitLoading) {
      // استخدام الـ Shimmer المحدث بنوع الـ Newest (القائمة الرأسية)
      return const BooksShimmerLoading(
        key: ValueKey('loading'),
        type: ShimmerType.newest,
      );
    } else {
      return const Center(
        key: ValueKey('initial'),
        child: Text('start searching for books.'),
      );
    }
  }
}
