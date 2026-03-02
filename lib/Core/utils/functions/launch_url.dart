import 'package:bookly_app/Core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchBookUrl(
  BuildContext context,
  String? url, {
  bool isFree = false,
}) async {
  if (url != null) {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      // لو الكتاب مجاني بنطلع رسالة إيجابية
      if (isFree && context.mounted) {
        customSnackBar(
          context,
          'Enjoy reading! This book is free to access.',
          Colors.green, // لون إيجابي
        );
      }
    } else {
      // التأكد من أن الـ context لسه موجود بعد الـ await
      if (context.mounted) {
        customSnackBar(
          context,
          'Cannot launch $url',
          Colors.orange, // لون تحذيري
        );
      }
    }
  }
}