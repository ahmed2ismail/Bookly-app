import 'package:bookly_app/Core/utils/functions/launch_url.dart';
import 'package:bookly_app/Features/home/data/models/books_model/books_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Core/widgets/custom_button.dart';

class BooksActionButtons extends StatelessWidget {
  const BooksActionButtons({super.key, required this.booksModel});

  final BooksModel booksModel;
  @override
  Widget build(BuildContext context) {
    // تحديد لو الكتاب مجاني ولا لا عشان نستخدمها في كذا مكان
    bool isFree = booksModel.saleInfo?.listPrice?.amount == null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              // '19.99 €',
              text: booksModel.saleInfo?.listPrice?.amount == null
                  ? 'Free'
                  : '${booksModel.saleInfo!.listPrice!.amount} ${booksModel.saleInfo!.listPrice!.currencyCode}',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
              onPressed: () async {
                // بنحاول نجيب لينك الشراء من الـ saleInfo
                String? buyUrl = booksModel.saleInfo?.buyLink;
                if (buyUrl != null) {
                  // هنا بنفتح لينك الشراء وممكن نمرر isFree لو هو فعلاً مجاني
                  await launchBookUrl(context, buyUrl, isFree: isFree);
                } else {
                  // لو مفيش لينك شراء (وده بيحصل في الكتب الـ NOT_FOR_SALE)
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'This book is not available for purchase',
                        ),
                        backgroundColor: Colors.orange, // لون تحذيري
                      ),
                    );
                  }
                }
              },
            ),
          ),
          Container(width: 0.5.w, color: Colors.black, height: 48.h),
          Expanded(
            child: CustomButton(
              text: booksModel.volumeInfo.previewLink == null
                  ? 'Not Available'
                  : 'Preview',
              backgroundColor: const Color(0xffEF8262),
              textColor: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              fontsize: 16.sp,
              onPressed: () async {
                // بنحاول نفتح رابط القارئ أولاً، لو مش موجود نفتح رابط المعاينة التقليدي
                String? url =
                    booksModel.accessInfo?.webReaderLink ??
                    booksModel.volumeInfo.previewLink;
                // تمرير حالة المجانية لإظهار الرسالة الإيجابية
                await launchBookUrl(context, url, isFree: isFree);
              },
            ),
          ),
        ],
      ),
    );
  }
}
