import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'action_button.dart';
import 'community_header.dart';
import 'image_placeholder.dart';
import 'post_title.dart';
import 'post_description.dart';

class GlobalWidgets {
  /// **Custom Bottom Navigation Bar**
  /// Dynamic bottom navigation bar with customizable items and behavior.
  static Widget customBottomNavigationBar({
    required int selectedIndex,
    required Function(int) onTap,
    List<BottomNavigationBarItem>? items,
  }) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onTap,
      backgroundColor: Colors.grey[900],
      selectedItemColor: Colors.cyanAccent,
      unselectedItemColor: Colors.white54,
      type: BottomNavigationBarType.fixed,
      items: items ??
          const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
          ],
    );
  }

  /// **Post Card Widget**
  /// Dynamic post card widget with options for title, description, likes, comments, and more.
  static Widget postCard({
    required String communityName,
    required String postTitle,
    required String description,
    required bool isImagePost,
    required int likes,
    required int comments,
    required VoidCallback onLike,
    required VoidCallback onComment,
    VoidCallback? onShare,
    Color? cardColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: cardColor ?? Colors.grey[900],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityHeader(communityName: communityName),
          SizedBox(height: 1.h),
          if (postTitle.isNotEmpty) PostTitle(postTitle: postTitle),
          if (!isImagePost && description.isNotEmpty)
            PostDescription(description: description),
          if (isImagePost) const ImagePlaceholder(),
          _actionRow(
            onLike: onLike,
            onComment: onComment,
            onShare: onShare,
            likes: likes,
            comments: comments,
          ),
        ],
      ),
    );
  }

  /// **Action Row**
  static Widget _actionRow({
    required VoidCallback onLike,
    required VoidCallback onComment,
    VoidCallback? onShare,
    required int likes,
    required int comments,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ActionButton(icon: Icons.thumb_up_alt_outlined, label: likes.toString(), onPressed: onLike),
          ActionButton(icon: Icons.chat_bubble_outline, label: comments.toString(), onPressed: onComment),
          if (onShare != null)
            ActionButton(icon: Icons.send, label: "Share", onPressed: onShare),
        ],
      ),
    );
  }
}
