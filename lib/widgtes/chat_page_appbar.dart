import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:synergee/app/screens/chat_screen.dart';
import '../app/screens/home.dart';
import '../app/themes/colors.dart';

PreferredSizeWidget buildChatAppBar({
  required String displayName,
  required String? photoURL,
}) {
  return AppBar(
    backgroundColor: AppColors.background,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back, color: AppColors.primary),
      onPressed: () => Get.off(() => ChatScreen())
    ),
    title: Row(
      children: [
        CircleAvatar(
          backgroundImage: photoURL != null ? NetworkImage(photoURL) : null,
          child: photoURL == null
              ? const Icon(Icons.person, color: AppColors.text)
              : null,
        ),
        const SizedBox(width: 10),
        Text(
          displayName,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
