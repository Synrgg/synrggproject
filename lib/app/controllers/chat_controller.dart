import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  var isLoading = true.obs;
  var allUsers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllUsersWithLastMessages();
  }
  Future<void> fetchAllUsersWithLastMessages() async {
    isLoading.value = true;

    try {
      final response = await supabase
          .from('users')
          .select('id, name, email, messages:messages!sender_id(content, created_at)');

      if (response != null && response is List) {
        // Sort the messages by 'created_at' in descending order
        final sortedUsers = List<Map<String, dynamic>>.from(response).map((user) {
          if (user['messages'] != null && user['messages'] is List<dynamic>) {
            final messages = List<Map<String, dynamic>>.from(user['messages']);
            messages.sort((a, b) {
              final aTime = DateTime.parse(a['created_at'] ?? '');
              final bTime = DateTime.parse(b['created_at'] ?? '');
              return bTime.compareTo(aTime); // Sort in descending order
            });
            user['messages'] = messages; // Assign sorted messages back
          }
          return user;
        }).toList();

        allUsers.assignAll(sortedUsers);
      } else {
        allUsers.clear();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users with messages: $e');
    } finally {
      isLoading.value = false;
    }
  }


}
