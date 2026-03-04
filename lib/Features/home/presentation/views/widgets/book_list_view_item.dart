import 'package:bookly_app/Core/utils/app_router.dart';
import 'package:bookly_app/Core/utils/styles.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/book_rating.dart';
import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_image.dart';
import 'package:bookly_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BookListViewItem extends StatelessWidget {
  const BookListViewItem({super.key, required this.booksModel});

  // final String imageUrl, title, author, price; // المنظر دا مش حلو خالص لانه مخالف لل oop فلازم ن encapsulate الحاجات دي جوه model مثلا نتعامل مع الموديل دا
  final BooksModel booksModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kBookDetailsView, extra: booksModel);
      },
      child: SizedBox(
        height: 130.h,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CustomBookImage(
                imageUrl: booksModel.volumeInfo.imageLinks?.thumbnail ?? '',
              ),
            ),
            SizedBox(width: 30.w),
            Expanded(
              // عشان ال row اللي جواه يتوسع وياخد مساحته لان ال Column بيعمل shrink
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    booksModel.volumeInfo.title,
                    // 'Harry Potter and the Goblet of Fire',
                    style: Styles.textStyle20.copyWith(
                      fontFamily: kGTSectraFine,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    // بنستخدم ?.first ?? 'Unknown' عشان نهندل الـ null safety زي ما اتفقنا
                    booksModel.volumeInfo.authors?.first ?? 'Unknown Author',
                    // 'J.K. Rowling',
                    style: Styles.textStyle14.copyWith(color: kAppGreyColor),
                    maxLines: 1, // عشان مياخدش سطر تاني ويزيح التقييم لتحت
                    overflow:
                        TextOverflow.ellipsis, // يضيف نقاط (...) لو الاسم طويل
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Free',
                        // '19.99 €',
                        style: Styles.textStyle20.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      BookRating(
                        rating: booksModel.volumeInfo.averageRating ?? 0,
                        count: booksModel.volumeInfo.ratingsCount ?? 0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
