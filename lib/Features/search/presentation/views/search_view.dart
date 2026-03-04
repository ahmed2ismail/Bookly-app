import 'package:flutter/material.dart';
import 'widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset:
          false, // ده هيمنع الـ Scaffold إنه يغير حجمه لما الكيبورد يظهر
      body: SafeArea(child: SearchViewBody()),
    );
  }
}
