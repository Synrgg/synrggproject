import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../app/themes/colors.dart';

class ContentCard extends StatelessWidget {
  final Map<String, dynamic> item;
  static final List<double> cardHeights = [20.h, 45.h, 30.h];
  static int currentIndex = 0;

  const ContentCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = cardHeights[currentIndex];
    currentIndex = (currentIndex + 1) % cardHeights.length;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: cardHeight,
            decoration: BoxDecoration(
              color: AppColors.cardBackground, // Card background color
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Center(
                  child: Icon(
                    Icons.image,
                    size: cardHeight * 0.25,
                    color: AppColors.iconPlaceholder, // Placeholder icon color
                  ),
                ),
                Positioned(
                  top: 3.w,
                  right: 3.w,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.moreIconBackground, // Icon button background
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      iconSize: 18.sp,
                      padding: EdgeInsets.all(2.w),
                      constraints: BoxConstraints(
                        minHeight: 10.w,
                        minWidth: 10.w,
                      ),
                      icon: const Icon(
                        Icons.more_horiz,
                        color: AppColors.text, // Icon color
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(
                    color: AppColors.text, // Text color
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.5.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item['description'],
                        style: TextStyle(
                          color: AppColors.subText, // Subtext color
                          fontSize: 14.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Icon(
                        Icons.arrow_forward,
                        color: AppColors.icon, // Arrow icon color
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
