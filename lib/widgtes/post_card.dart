import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostCard extends StatelessWidget {
  final String communityName;
  final String postTitle;
  final String description;
  final bool isImagePost;
  final int likes;
  final int comments;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostCard({
    Key? key,
    required this.communityName,
    required this.postTitle,
    required this.description,
    required this.isImagePost,
    required this.likes,
    required this.comments,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Community Name Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 5.w,
                    backgroundColor: Colors.cyanAccent,
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
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onPressed: () {
                  // Handle more options
                },
              ),
            ],
          ),
          SizedBox(height: 1.h),

          // Post Title
          if (postTitle.isNotEmpty)
            Text(
              postTitle,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

          // Post Description (if not an image post)
          if (!isImagePost && description.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white70,
                ),
              ),
            ),

          // Image for Image Post
          if (isImagePost)
            Container(
              margin: EdgeInsets.only(top: 2.h),
              height: 20.h,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(Icons.image, color: Colors.white54, size: 12.w),
              ),
            ),

          // Like, Comment, and Share Row
          Padding(
            padding: EdgeInsets.only(top: 1.5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onLike,
                  child: Row(
                    children: [
                      Icon(Icons.thumb_up_alt_outlined, color: Colors.white54, size: 18.sp),
                      SizedBox(width: 1.w),
                      Text(
                        likes.toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onComment,
                  child: Row(
                    children: [
                      Icon(Icons.chat_bubble_outline, color: Colors.white54, size: 18.sp),
                      SizedBox(width: 1.w),
                      Text(
                        comments.toString(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: onShare,
                  child: const Icon(Icons.send, color: Colors.white54, size: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
