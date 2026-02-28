import 'package:bookly_app/Core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errMessage;
  final VoidCallback onPressed; // إضافة الـ Callback هنا لجعله عاماً

  const CustomErrorWidget({
    super.key, 
    required this.errMessage, 
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errMessage, 
            style: Styles.textStyle18, 
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          IconButton(
            onPressed: onPressed, // تنفيذ الوظيفة الممررة
            icon: const Icon(Icons.refresh, size: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }
}