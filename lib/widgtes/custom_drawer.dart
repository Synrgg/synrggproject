import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import '../app/controllers/home_screen_controller.dart';

class CustomDrawer extends StatelessWidget {
  final HomeScreenController controller;

  const CustomDrawer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDrawerHeader(),
            Expanded(
              child: ListView(
                children: [
                  _buildAnimatedListTile(
                    icon: Icons.settings,
                    title: "Settings",
                    color: Colors.cyanAccent,
                    onTap: () {
                      // Handle settings tap
                      print("Settings tapped");
                    },
                  ),
                  _buildAnimatedListTile(
                    icon: Icons.logout,
                    title: "Logout",
                    color: Colors.redAccent,
                    onTap: () {
                      // Handle logout tap
                      print("Logout tapped");
                    },
                  ),
                  _buildAnimatedListTile(
                    icon: Icons.help_outline,
                    title: "Help",
                    color: Colors.lightGreenAccent,
                    onTap: () {
                      // Handle help tap
                      print("Help tapped");
                    },
                  ),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.cyanAccent,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: AssetImage('assets/images/avatar.png'),
            backgroundColor: Colors.transparent,
          ),
          const SizedBox(height: 10),
          Obx(() {
            return Text(
              controller.userName.value,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.cyanAccent.withOpacity(0.8),
                    blurRadius: 5,
                    offset: Offset(1, 2),
                  ),
                ],
              ),
            );
          }),
          Obx(() {
            return Text(
              controller.userEmail.value,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAnimatedListTile({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
      hoverColor: Colors.cyanAccent.withOpacity(0.2),
      contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: Colors.black.withOpacity(0.3),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
      child: Text(
        "Powered by Synrgg",
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white70,
          fontWeight: FontWeight.w500,
          shadows: [
            Shadow(
              color: Colors.cyanAccent.withOpacity(0.8),
              blurRadius: 3,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }
}

