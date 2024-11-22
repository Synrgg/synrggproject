import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../app/controllers/home_screen_controller.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final HomeScreenController controller;

  const CustomAppBar({Key? key, required this.controller}) : super(key: key);

  @override
  Size get preferredSize =>
      Size.fromHeight(6.h); // Adjust AppBar height dynamically

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      elevation: 5,
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 129, 34, 213),
      ), // Set hamburger icon color to cyan
      title: Obx(() {
        return controller.isSearchActive.value
            ? TextField(
                onChanged: (value) => controller.searchQuery.value = value,
                style: const TextStyle(color: Colors.white),
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search, color: Colors.white54),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: controller.toggleSearchBar,
                  ),
                ),
              )
            : Container(
                child: Image.asset(
                  'assets/images/Logo.png',
                  height: 30.h,
                  width: 40.w,
                ),
              );
      }),
      actions: [
        if (!controller.isSearchActive.value)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 22),
            onPressed: controller.toggleSearchBar,
          ),
        if (!controller.isSearchActive.value)
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white, size: 22),
            onPressed: () {
              // Navigate to user account page
            },
          ),
      ],
    );
  }
}
