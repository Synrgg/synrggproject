import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController extends GetxController {
  var isLoading = true.obs;
  var allUsers = <Map<String, dynamic>>[].obs;

  final SupabaseClient supabase = Supabase.instance.client;
  String? currentUserId;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserId();
    fetchAllUsers();
  }

  // Fetch the currently authenticated user's ID
  void fetchCurrentUserId() {
    final user = supabase.auth.currentUser;
    if (user != null) {
      currentUserId = user.id;
    } else {
      Get.snackbar('Error', 'No authenticated user found.');
    }
  }

  // Fetch all users from the `users` table
  Future<void> fetchAllUsers() async {
    if (currentUserId == null) {
      Get.snackbar('Error', 'User ID is null. Authentication required.');
      return;
    }

    isLoading.value = true;

    try {
      // Fetch users excluding the current user
      final response = await supabase
          .from('users') // Use the correct table name
          .select('id, display_name, avatar_url, last_seen')
          .neq('id', currentUserId!); // Exclude current user

      allUsers.assignAll(List<Map<String, dynamic>>.from(response));
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Generate a unique chat room ID for two users
  String getChatRoomId(String currentUserId, String userId) {
    return currentUserId.hashCode <= userId.hashCode
        ? '$currentUserId-$userId'
        : '$userId-$currentUserId';
  }
}
