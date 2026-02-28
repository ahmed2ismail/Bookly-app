import 'package:bookly_app/Core/widgets/custom_loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomBookImage extends StatelessWidget {
  const CustomBookImage({super.key, required this.imageUrl});

  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        // AspectRatio widget: بتستخدم لضبط نسبة الطول والعرض وبتطنش ال width, height بتاع ال child
        // يعني انا بقولها انا هديكي قيمة واحدة وعايزك تظبطي القيمة التانية علي اساسها
        aspectRatio: 2.6 / 4,
        // child: Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: NetworkImage(imageUrl),
        //       // ال NetworkImage ليها شوية عيوب منها ان لما بعمل restart للتطبيق الصور مش بتكون لسه اتحملت فبيجبلي loading indicator وتاني مشكلة لما اعمل rebuild فوقتها الصور بتتحمل مرة اخرى ودا بيستهلك النت والمشكلة التالتة ان لو ال url بتاع الصورة غلط فهو مش بيقدر يحملها اصلا ومش بيقولي المشكلة فين
        //       // هنحل المشاكل دي عن طريق cached_network_image package
        //       // بعد مضيفها لازم اوقف التطبيق واشغله تاني
        //       fit: BoxFit.fill,
        //     ),
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        // ),
        child: CachedNetworkImage(
          // بستخدمها عشان اعرض كل ال urls اللي بتيجي من علي النت
          imageUrl: imageUrl,
          fit: BoxFit.fill,
          // placeholder: (context, url) => const CustomLoadingIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        // ال CachedNetworkImage بتكيش الداتا يعني بتحملها مرة واحدة بس وبتحفظها والظهور بتاع الصور بيكون بشكل سلس ولو اللينك غلط بيعرضلي علي الشاشة المشكلة
      ),
    );
  }
}
