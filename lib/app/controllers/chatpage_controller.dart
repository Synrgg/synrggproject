import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatPageController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  /// Function to send a message to Supabase
  Future<bool> sendMessage({
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

      if (response.error == null) {
        return true;
      } else {
        print('Supabase Error: ${response.error!.message}');
        return false;
      }
    } catch (e) {
      print('Error sending message: $e');
      return false;
    }
  }
}
