import 'package:bookly_app/Core/utils/functions/custom_snack_bar.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomBookDetailsAppBar extends StatelessWidget {
  const CustomBookDetailsAppBar({super.key, required this.booksModel});

  final BooksModel
  booksModel; // لازم نضيف المتغير ده عشان نقدر نوصل للينك بتاع الشراء من الموديل
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 32),
        ),
        IconButton(
          onPressed: () async {
            // سحب لينك الشراء من الموديل عشان نعملها لينك شراء سريع
            String? buyUrl = booksModel.saleInfo?.buyLink;
            if (buyUrl != null) {
              // استخدام الدالة اللي عملناها سوا للـ url_launcher
              Uri uri = Uri.parse(buyUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            } else {
              // رسالة لو الكتاب غير متاح للبيع
              customSnackBar(
                context,
                'Purchase link not available',
                Colors.red,
              );
            }
          },
          icon: const Icon(Icons.shopping_cart_outlined, size: 32),
        ),
      ],
    );
  }
}
