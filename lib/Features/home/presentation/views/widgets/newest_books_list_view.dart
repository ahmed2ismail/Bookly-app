import 'package:bookly_app/Core/widgets/custom_error_widget.dart';
import 'package:bookly_app/Core/widgets/books_shimmer_loading.dart';
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
        if (state is NewestBooksSuccess) {
          return ListView.builder(
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
            errMessage: state.errMessage,
            onPressed: () {
              BlocProvider.of<NewestBooksCubit>(context).fetchNewestBooks();
            },
          );
        } else {
          return const BooksShimmerLoading(isHorizontal: false,);
        }
      },
    );
  }
}
