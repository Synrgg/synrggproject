import 'package:get/get.dart';

class HomeController extends GetxController {
  // State management variables
  var isSearchActive = false.obs;
  var searchQuery = ''.obs;
  var selectedIndex = 0.obs;

  // Toggle search bar visibility
  void toggleSearchBar() {
    isSearchActive.value = !isSearchActive.value;
    if (!isSearchActive.value) {
      searchQuery.value = '';
    }
  }

  // Handle bottom navigation bar tab changes
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Additional logic for API calls, data updates, etc., can be added here
}
