import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/themes/colors.dart';
import 'media_options.dart';

class MessageInput extends StatelessWidget {
  final String chatId;
  final String userId;
  final Future<bool> Function({
  required String chatId,
  required String userId,
  required String message,
  }) sendMessage; // External callback to handle message sending
  final VoidCallback onMessageSent; // Callback to update UI after sending

  const MessageInput({
    required this.chatId,
    required this.userId,
    required this.sendMessage,
    required this.onMessageSent,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(8),
      color: AppColors.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add Button
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                backgroundColor: AppColors.inputBackground,
                builder: (context) => const MediaOptionsPopup(),
              );
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: AppColors.primary, size: 24),
            ),
          ),
          const SizedBox(width: 10),

          // Message Input Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: messageController,
                style: const TextStyle(color: AppColors.text),
                decoration: const InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: TextStyle(color: AppColors.subText),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Send Button
          GestureDetector(
            onTap: () async {
              final message = messageController.text.trim();
              if (message.isNotEmpty) {
                // Call the provided sendMessage function
                final success = await sendMessage(
                  chatId: chatId,
                  userId: userId,
                  message: message,
                );

                if (success) {
                  messageController.clear();
                  onMessageSent(); // Trigger UI update callback
                } else {
                  Get.snackbar(
                    'Error',
                    'Failed to send message. Try again.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
