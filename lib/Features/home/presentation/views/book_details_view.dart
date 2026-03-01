import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly_app/Features/home/presentation/manager/Similar_Books_Cubit/similar_books_cubit.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_details_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookDetailsView extends StatefulWidget {
  const BookDetailsView({super.key, required this.booksModel});

  final BooksModel booksModel;
  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  @override
  void initState() {
    // لازم نهندل حالة إن الكتاب ملوش Categories
    // بنشيك لو فيه تصنيف، لو مفيش بنبحث عن "Programming" ككلمة عامة
    String category =
        widget.booksModel.volumeInfo.categories?.isNotEmpty == true
        ? widget.booksModel.volumeInfo.categories![0]
        : 'Programming';
    BlocProvider.of<SimilarBooksCubit>(
      context,
    ).fetchSimilarBooks(category: category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: BookDetailsViewBody()));
  }
}
