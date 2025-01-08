import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/themes/colors.dart';

class MessageList extends StatelessWidget {
  final String chatId;

  const MessageList({
    required this.chatId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: Supabase.instance.client
          .from('messages')
          .stream(primaryKey: ['id'])
          .eq('chat_id', chatId)
          .order('created_at', ascending: false)
          .map((data) => List<Map<String, dynamic>>.from(data)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primary));
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: AppColors.error),
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'No messages yet.',
              style: TextStyle(color: AppColors.subText),
            ),
          );
        }

        final messages = snapshot.data!;

        return ListView.builder(
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMe = message['sender_id'] ==
                Supabase.instance.client.auth.currentUser?.id;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.primary : Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  message['content'] ?? '',
                  style: const TextStyle(color: AppColors.text),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
