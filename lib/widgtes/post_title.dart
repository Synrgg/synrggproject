import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostTitle extends StatelessWidget {
  final String postTitle;

  const PostTitle({Key? key, required this.postTitle}) : super(key: key);

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
