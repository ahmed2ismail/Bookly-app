import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/books_actions.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsSection extends StatelessWidget {
  const BookDetailsSection({super.key, required this.booksModel});

  final BooksModel booksModel;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width.w;
    return Column(
      children: [
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .2.w),
          child: CustomBookImage(
            imageUrl: booksModel.volumeInfo.imageLinks?.thumbnail ?? '',
            // 'https://www.pexels.com/photo/assorted-dvd-case-lot-on-shelves-276005/',
          ),
        ),
        SizedBox(height: 43.h),
        Text(
          booksModel.volumeInfo.title,
          // 'The Jungle Book',
          style: Styles.textStyle30.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 6.h),
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
        SizedBox(height: 18.h),
        BookRating(
          mainAxisAlignment: MainAxisAlignment.center,
          rating: booksModel.volumeInfo.averageRating ?? 0,
          count: booksModel.volumeInfo.ratingsCount ?? 0,
        ),
        SizedBox(height: 37.h),
        BooksActionButtons(booksModel: booksModel,),
      ],
    );
  }
}
