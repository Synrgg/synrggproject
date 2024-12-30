import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostTitle extends StatelessWidget {
  final String postTitle;

  const PostTitle({super.key, required this.postTitle});

  @override
  Widget build(BuildContext context) {
    return Text(
      postTitle,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
