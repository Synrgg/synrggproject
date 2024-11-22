import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreenController extends GetxController {
  // Observable variables for user information
  var userAvatarPath = 'assets/user_avatar.png'.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;

  // Observable variables for search and posts
  var isSearchActive = false.obs;
  var searchQuery = ''.obs;
  var posts = <Map<String, dynamic>>[].obs;
  var filteredPosts = <Map<String, dynamic>>[].obs;

  // Observable variable for bottom navigation
  var selectedIndex = 0.obs;

  // Observable variable for floating button menu
  var isFloatingMenuOpen = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch user details from Firebase
    fetchUserDetails();
    // Initialize posts
    loadPosts();
    debounce(searchQuery, (_) => filterPosts(),
        time: const Duration(milliseconds: 300));
  }

  Future<void> fetchUserDetails() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        userEmail.value = currentUser.email ?? 'No email';
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (userDoc.exists) {
          userName.value = userDoc['name'] ?? 'No name';
          userAvatarPath.value =
              userDoc['avatarPath'] ?? 'assets/user_avatar.png';
        } else {
          userName.value = 'Anonymous';
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to fetch user details. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
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

  void toggleSearchBar() {
    isSearchActive.toggle();
    if (!isSearchActive.value) {
      searchQuery.value = '';
      filteredPosts.assignAll(posts);
    }
  }

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

  void toggleFloatingMenu() {
    isFloatingMenuOpen.toggle();
  }

  void likePost(int index) {
    filteredPosts[index]['likes']++;
  }

  void addComment(int index) {
    filteredPosts[index]['comments']++;
  }

  void changeTab(int index) {
    selectedIndex.value = index;
  }
}
