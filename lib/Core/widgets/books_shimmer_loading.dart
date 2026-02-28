import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BooksShimmerLoading extends StatelessWidget {
  final bool
  isHorizontal; // لو true يرسم الـ Featured، لو false يرسم الـ Newest

  const BooksShimmerLoading({super.key, this.isHorizontal = true});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[700]!,
      // بنختار شكل القائمة بناءً على المتغير
      child: isHorizontal ? _buildFeaturedLoading() : _buildNewestLoading(),
    );
  }

  // شكل الـ Featured (الأفقي)
  Widget _buildFeaturedLoading() {
    return SizedBox(
      height: 200, // نفس ارتفاع الـ Featured عندك
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
              width: 70,
              height: 100,
              color: Colors.black,
            ), // محاكاة الصورة
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 15,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 10),
                  Container(width: 100, height: 15, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
