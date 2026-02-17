import 'package:bookly_app/Core/utils/assets.dart';
import 'package:flutter/material.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 60,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment
          .stretch, // عشان ال child اللي هو الصورة تاخد ال width بتاع الشاشة
      children: [
        Image.asset(AssetsData.logo),
        const Text(
          'Enjoy Readying with your favorite books',
          style: TextStyle(color: Colors.white, fontSize: 17),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
