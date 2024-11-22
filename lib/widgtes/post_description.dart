import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostDescription extends StatelessWidget {
  final String description;

  const PostDescription({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Text(
        description,
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white70,
        ),
      ),
    );
  }
}
