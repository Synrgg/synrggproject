import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../app/controllers/community_screen_controller.dart';
import '../app/screens/profile_screen.dart';
import '../app/themes/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CommunityScreenController controller;

  const CustomAppBar({super.key, required this.controller});

  @override
  Size get preferredSize => Size.fromHeight(6.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 5,
      iconTheme: const IconThemeData(
        color: AppColors.primary,
      ),
      title: Obx(() {
        return controller.isSearchActive.value
            ? buildSearchField()
            : buildLogo();
      }),
      actions: buildActions(),
    );
  }

  Widget buildSearchField() {
    return TextField(
      onChanged: (value) => controller.searchQuery.value = value,
      style: const TextStyle(color: AppColors.text),
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: const TextStyle(color: AppColors.subText),
        border: InputBorder.none,
        prefixIcon: const Icon(Icons.search, color: AppColors.subText),
        suffixIcon: IconButton(
          icon: const Icon(Icons.close, color: AppColors.text),
          onPressed: controller.toggleSearchBar,
        ),
      ),
    );
  }

  Widget buildLogo() {
    return Image.asset(
      'assets/images/Logo.png',
      height: 30.h,
      width: 40.w,
    );
  }

  List<Widget> buildActions() {
    return [
      if (!controller.isSearchActive.value)
        IconButton(
          icon: const Icon(Icons.search, color: AppColors.text, size: 22),
          onPressed: controller.toggleSearchBar,
        ),
      if (!controller.isSearchActive.value)
        IconButton(
          icon: const Icon(Icons.person, color: AppColors.text, size: 22),
          onPressed: () {
            Get.to(
                  () => const ProfileScreen(),
              arguments: {
                "username": "JohnDoe",
                "valorantData": {
                  "rank": "Platinum",
                  "kda": "1.67",
                  "matches": "120",
                  "winrate": "65%",
                },
                "bgmiData": {
                  "rank": "Ace",
                  "kda": "4.23",
                  "matches": "150",
                  "winrate": "72%",
                },
              },
            );
          },
        ),
    ];
  }
}
