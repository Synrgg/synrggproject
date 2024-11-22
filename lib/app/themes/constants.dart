import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// Common colors
class AppColors {
  static const Color primary = Colors.cyanAccent;
  static const Color background = Colors.black;
  static const Color text = Colors.white;
  static const Color subText = Colors.white70;
}

// Font sizes dynamically scalable
class FontSizes {
  static double title = 22.sp;
  static double body = 14.sp;
  static double small = 12.sp;
}

// Common styles
class AppTextStyles {
  static TextStyle title = TextStyle(
    fontSize: FontSizes.title,
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static TextStyle body = TextStyle(
    fontSize: FontSizes.body,
    color: AppColors.text,
  );

  static TextStyle subText = TextStyle(
    fontSize: FontSizes.small,
    color: AppColors.subText,
  );
}
