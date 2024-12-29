import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredUsers = <Map<String, dynamic>>[].obs;
  var searchText = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      final snapshot = await FirebaseFirestore.instance.collection('users').get();
      users.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      filteredUsers.value = users; // Initially, show all users
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch users: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchText(String text) {
    searchText.value = text;
    if (text.isEmpty) {
      filteredUsers.value = users; // Reset to all users if the search is cleared
    } else {
      filteredUsers.value = users
          .where((user) => user["displayName"]
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase()))
          .toList();
    }
  }

  void toggleSearch() {
    if (searchText.isEmpty) {
      searchText.value = '';
      filteredUsers.value = users; // Reset search
    } else {
      searchText.value = '';
    }
  }
}
