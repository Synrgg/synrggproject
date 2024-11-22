import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommunityHeader extends StatelessWidget {
  final String communityName;

  const CommunityHeader({Key? key, required this.communityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 5.w,
              backgroundColor: Colors.cyanAccent,
              child: const Icon(
                Icons.group,
                color: Colors.black,
                size: 18,
              ),
            ),
            SizedBox(width: 3.w),
            Text(
              communityName,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        IconButton(
          icon: Icon(Icons.more_vert, color: Colors.white),
          onPressed: () {
            // Handle more options
          },
        ),
      ],
    );
  }
}
