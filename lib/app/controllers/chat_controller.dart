import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;

  var isLoading = true.obs;
  var allUsers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    isLoading.value = true;

    try {
      final response = await supabase
          .from('profiles')
          .select('id, display_name, avatar_url, last_seen, created_at, email, updated_at ');

      if (response != null && response.isNotEmpty) {
        allUsers.assignAll(List<Map<String, dynamic>>.from(response));
      } else {
        allUsers.clear();
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
