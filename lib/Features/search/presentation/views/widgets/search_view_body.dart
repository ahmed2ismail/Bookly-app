import 'package:bookly_app/Features/search/presentation/manager/Search_Books_Cubit/search_books_cubit.dart';
import 'package:bookly_app/Features/search/presentation/views/widgets/search_result_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_search_text_field.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  // تعريف الـ Controller هنا عشان نتحكم في النص في كل الشاشة
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose(); // ضروري جداً لتجنب الـ Memory Leak
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // بنمرر الـ Controller للـ TextField
          CustomSearchTextField(controller: searchController),
          SizedBox(height: 42.h),
          Text(
            'Search Result',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          // هنا بنخلي عدد النتائج ديناميكي
          BlocBuilder<SearchBooksCubit, SearchBooksState>(
            builder: (context, state) {
              int count = 0;
              if (state is SearchCubitSuccess) {
                count = state.books.length; // جلب عدد الكتب الحقيقي
              }
              return Text(
                'results found: $count',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              );
            },
          ),
          SizedBox(height: 16.h),
          Expanded(
            // بنمرر الـ Controller عشان الـ Retry يشتغل صح في كل الشاشة
            child: SearchResultListView(searchController: searchController),
          ),
        ],
      ),
    );
  }
}
