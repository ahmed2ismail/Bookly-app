import 'dart:async';
import 'package:bookly_app/Features/search/presentation/manager/Search_Books_Cubit/search_books_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomSearchTextField extends StatefulWidget {
  // بنستقبل الـ controller من الـ SearchViewBody
  final TextEditingController controller;
  const CustomSearchTextField({super.key, required this.controller});

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  Timer? _debounce; // التايمر المسؤول عن الـ Debounce

  @override
  void dispose() {
    _debounce
        ?.cancel(); // لازم نكنسل التايمر لما الصفحة تقفل عشان ميعملش Memory Leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:
          widget.controller, // استخدام الـ Controller اللي جاي من الـ Parent
      onChanged: (value) {
        // كل ما المستخدم يكتب حرف، بنكنسل التايمر القديم ونبدأ واحد جديد
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(const Duration(milliseconds: 700), () {
          if (value.isNotEmpty) {
            // تنفيذ البحث بعد مرور 700 مللي ثانية من آخر حرف اتكتب
            BlocProvider.of<SearchBooksCubit>(
              context,
            ).fetchSearchBooks(bookName: value);
          }
        });
      },
      decoration: InputDecoration(
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        hintText: 'Search',
        suffixIcon: Opacity(
          opacity: 0.8,
          child: IconButton(
            onPressed: () {
              // إمكانية البحث اليدوي عند الضغط على الأيقونة
              if (widget.controller.text.isNotEmpty) {
                BlocProvider.of<SearchBooksCubit>(
                  context,
                ).fetchSearchBooks(bookName: widget.controller.text);
              }
            },
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
          ),
        ),
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(color: Colors.white),
  );
}
