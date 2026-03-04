import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

// استخدام الـ Enum بيخلي الكود منظم أكتر
enum ShimmerType { featured, newest, similar }

class BooksShimmerLoading extends StatelessWidget {
  final ShimmerType type;

  const BooksShimmerLoading({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      period: const Duration(seconds: 2),
      child: _getShimmerShape(),
    );
  }

  Widget _getShimmerShape() {
    switch (type) {
      case ShimmerType.featured:
        return _buildFeaturedLoading();
      case ShimmerType.newest:
        return _buildNewestLoading();
      case ShimmerType.similar:
        return _buildSimilarBooksLoading();
    }
  }

  // شكل الـ Featured (الأفقي)
  Widget _buildFeaturedLoading() {
    return SizedBox(
      height: 200.h, // نفس ارتفاع الـ Featured عندك
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(right: 16),
          child: AspectRatio(
            aspectRatio: 2.6 / 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // شكل الـ Newest (الرأسي مع النصوص)
  Widget _buildNewestLoading() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Row(
          children: [
            Container(
              width: 70.w,
              height: 100.h,
              color: Colors.black,
            ), // محاكاة الصورة
            SizedBox(width: 20.w),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 15.h,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10.h),
                  Container(width: 100.w, height: 15.h, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // نفس الـ Featured بس أصغر شوية عشان صفحة الـ Details
  Widget _buildSimilarBooksLoading() {
    return SizedBox(
      height: 120.h, // مناسب جداً لحجم الصور في التصميم
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: AspectRatio(
            aspectRatio: 2.6 / 4, // نفس أبعاد صور الكتب في الـ Home
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(
                  8,
                ), // نفس الـ Radius في الصورة
              ),
            ),
          ),
        ),
      ),
    );
  }
}
