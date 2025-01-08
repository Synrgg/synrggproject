import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../widgtes/message_input.dart';
import '../../widgtes/message_list.dart';
import '../../widgtes/chat_page_appbar.dart';
import '../themes/colors.dart';

class ChatPage extends StatelessWidget {
  final String chatId;
  final String userId;
  final String displayName;
  final String? photoURL;

  const ChatPage({
    required this.chatId,
    required this.userId,
    required this.displayName,
    this.photoURL,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SupabaseClient supabase = Supabase.instance.client;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: buildChatAppBar(displayName: displayName, photoURL: photoURL),
      body: Column(
        children: [
          Expanded(
            child: MessageList(chatId: chatId),
          ),
          MessageInput(
            chatId: chatId,
            userId: userId,
            sendMessage: ({
              required String chatId,
              required String userId,
              required String message,
            }) async {
              try {
                final currentUserId = supabase.auth.currentUser?.id;
                if (currentUserId == null) {
                  throw Exception("User not authenticated");
                }

                final response = await supabase.from('messages').insert({
                  'chat_id': chatId,
                  'sender_id': currentUserId,
                  'receiver_id': userId,
                  'content': message,
                });

                return response.error == null;
              } catch (e) {
                print('Error sending message: $e');
                return false;
              }
            },
            onMessageSent: () {
              // Scroll the chat to the bottom or update the UI
              print("Message sent successfully!");
            },
          ),
        ],
      ),
    );
  }
}
