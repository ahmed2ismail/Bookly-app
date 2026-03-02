import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/books_actions.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Core/utils/styles.dart';
import 'package:flutter/material.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.booksModel});

  final BooksModel booksModel;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .2),
          child: CustomBookImage(
            imageUrl: booksModel.volumeInfo.imageLinks?.thumbnail ?? '',
            // 'https://www.pexels.com/photo/assorted-dvd-case-lot-on-shelves-276005/',
          ),
        ),
        const SizedBox(height: 43),
        Text(
          booksModel.volumeInfo.title,
          // 'The Jungle Book',
          style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Opacity(
          opacity: 0.7,
          child: Text(
            booksModel.volumeInfo.authors![0],
            // 'Rudyard Kipling',
            style: Styles.textStyle18.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
            ),
          textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 18),
        BookRating(
          mainAxisAlignment: MainAxisAlignment.center,
          rating: booksModel.volumeInfo.averageRating ?? 0,
          count: booksModel.volumeInfo.ratingsCount ?? 0,
        ),
        const SizedBox(height: 37),
        const BooksActionButtons(),
      ],
    );
  }
}
