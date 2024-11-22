import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../app/controllers/home_screen_controller.dart';

class FloatingActionMenu extends StatelessWidget {
  final HomeScreenController controller;

  const FloatingActionMenu({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => Stack(
        children: [
          if (controller.isFloatingMenuOpen.value)
            Positioned.fill(
              child: GestureDetector(
                onTap: controller.toggleFloatingMenu,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  color: Colors.black54,
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.isFloatingMenuOpen.value)
                  ...[
                    _buildFloatingMenuItem(
                      icon: Icons.post_add,
                      color: Colors.cyan,
                      label: "Add Post",
                      onPressed: () {
                        print("Add Post pressed");
                      },
                    ),
                    _buildFloatingMenuItem(
                      icon: Icons.create,
                      color: Colors.cyan,
                      label: "Create Post",
                      onPressed: () {
                        print("Create Post pressed");
                      },
                    ),
                    _buildFloatingMenuItem(
                      icon: Icons.upload_file,
                      color: Colors.cyan,
                      label: "Upload Post",
                      onPressed: () {
                        print("Upload Post pressed");
                      },
                    ),
                  ],
                FloatingActionButton(
                  backgroundColor: Colors.cyanAccent,
                  onPressed: controller.toggleFloatingMenu,
                  child: AnimatedRotation(
                    duration: const Duration(milliseconds: 300),
                    turns: controller.isFloatingMenuOpen.value ? 0.75 : 0,
                    child: const Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingMenuItem({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: FloatingActionButton.extended(
        backgroundColor: color,
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: const TextStyle(color: Colors.white)),
        onPressed: onPressed,
      ),
    );
  }
}
