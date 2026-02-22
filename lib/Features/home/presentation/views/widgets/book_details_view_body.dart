import 'package:bookly_app/Features/home/presentation/views/widgets/custom_book_details_appbar.dart';
import 'package:flutter/material.dart';

class BookDetailsViewBody extends StatelessWidget {
  const BookDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 30.7, right: 30.0, top: 40, bottom: 20),
      child: Column(children: [CustomBookDetailsAppBar()]),
    );
  }
}