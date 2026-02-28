import 'package:flutter/material.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key, required this.imageUrl});

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      // AspectRatio widget: بتستخدم لضبط نسبة الطول والعرض وبتطنش ال width, height بتاع ال child
      // يعني انا بقولها انا هديكي قيمة واحدة وعايزك تظبطي القيمة التانية علي اساسها
      aspectRatio: 2.6 / 4,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
