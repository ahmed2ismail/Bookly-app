import 'package:bookly_app/Core/utils/styles.dart';
import 'package:bookly_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BookRating extends StatelessWidget {
  const BookRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          size: 18,
          FontAwesomeIcons.solidStar,
          color: kRatingStarColor,
        ),
        const SizedBox(width: 6.3),
        const Text('4.8', style: Styles.textStyle16),
        const SizedBox(width: 5),
        Text(
          '(2390)',
          style: Styles.textStyle14.copyWith(color: kAppGreyColor),
        ),
      ],
    );
  }
}
