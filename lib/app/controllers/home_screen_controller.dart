import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  // Observable variables for user information
  var userAvatarPath = 'assets/user_avatar.png'.obs;
  var userName = 'Admin'.obs;
  var userEmail = 'synrgg@gmail.com'.obs;

  // Observable variables for search and posts
  var isSearchActive = false.obs; // Tracks the visibility of the search bar
  var searchQuery = ''.obs; // Tracks the current search query
  var posts = <Map<String, dynamic>>[].obs; // Original list of posts
  var filteredPosts = <Map<String, dynamic>>[].obs; // Filtered posts for search

  // Observable variable for bottom navigation
  var selectedIndex = 0.obs;

  // Observable variable for floating button menu
  var isFloatingMenuOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize posts
    loadPosts();
    debounce(searchQuery, (_) => filterPosts(), time: const Duration(milliseconds: 300));
  }

  void loadPosts() {
    posts.assignAll([
      {
        'communityName': 'Valorant Community',
        'postTitle': 'Game Update!',
        'description': 'New agent "Deadlock" revealed. What are your thoughts?',
        'isImagePost': false,
        'likes': 10.obs,
        'comments': 5.obs,
      },
      {
        'communityName': 'Fortnite Updates',
        'postTitle': 'Image Post',
        'description': '',
        'isImagePost': true,
        'likes': 25.obs,
        'comments': 15.obs,
      },
      {
        'communityName': 'CS:GO Fans',
        'postTitle': 'Text Post',
        'description': 'Did you hear about the new CS2 mechanics?',
        'isImagePost': false,
        'likes': 40.obs,
        'comments': 20.obs,
      },
      {
        'communityName': 'Minecraft Builders',
        'postTitle': 'Share Your Creations!',
        'description': 'Post your favorite Minecraft builds below!',
        'isImagePost': false,
        'likes': 60.obs,
        'comments': 30.obs,
      },
      {
        'communityName': 'Apex Legends Squad',
        'postTitle': 'Image Post',
        'description': '',
        'isImagePost': true,
        'likes': 50.obs,
        'comments': 25.obs,
      },
    ]);
    filteredPosts.assignAll(posts);
  }

  // Toggle search bar visibility
  void toggleSearchBar() {
    isSearchActive.toggle();
    if (!isSearchActive.value) {
      searchQuery.value = '';
      filteredPosts.assignAll(posts);
    }
  }

  // Filter posts based on the search query
  void filterPosts() {
    if (searchQuery.isEmpty) {
      filteredPosts.assignAll(posts);
    } else {
      filteredPosts.assignAll(
        posts.where((post) {
          return post['communityName']
              .toString()
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()) ||
              post['postTitle']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()) ||
              post['description']
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase());
        }).toList(),
      );
    }
  }

  // Toggle floating button menu
  void toggleFloatingMenu() {
    isFloatingMenuOpen.toggle();
  }

  // Handle Like functionality
  void likePost(int index) {
    filteredPosts[index]['likes']++;
  }

  // Handle Comment functionality
  void addComment(int index) {
    filteredPosts[index]['comments']++;
  }

  // Change bottom navigation tab
  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
