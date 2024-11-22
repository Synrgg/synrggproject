import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
      height: 20.h,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(Icons.image, color: Colors.white54, size: 12.w),
      ),
    );
  }
}
