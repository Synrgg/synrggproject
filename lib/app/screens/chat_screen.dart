import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synergee/app/screens/home.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 129, 34, 213)),
          onPressed: () {
            Get.offAll(() => HomePage());

          },
        ),
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: chatController.searchText.isEmpty
              ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Inbox',
                style: TextStyle(
                  color: Color.fromARGB(255, 129, 34, 213),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Orbitron',
                ),
              ),
              // Icon(Icons.chat_bubble_outline, color: Colors.cyanAccent, size: 22),
            ],
          )
              : TextField(
            key: ValueKey("search"),
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search users...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            style: TextStyle(color: Colors.white, fontSize: 18),
            onChanged: (value) {
              chatController.updateSearchText(value);
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              chatController.searchText.isEmpty ? Icons.search : Icons.close,
              color: Color.fromARGB(255, 129, 34, 213),
            ),
            onPressed: () {
              chatController.toggleSearch();
            },
          ),
          IconButton(
            icon: Icon(Icons.group, color: Color.fromARGB(255, 129, 34, 213)),
            onPressed: () {
              Get.snackbar(
                "Feature",
                "Group functionality is under development.",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (chatController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Color.fromARGB(255, 129, 34, 213)),
          );
        }

        if (chatController.filteredUsers.isEmpty) {
          return Center(
            child: Text(
              'No users found.',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(10),
          itemCount: chatController.filteredUsers.length,
          itemBuilder: (context, index) {
            final user = chatController.filteredUsers[index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 129, 34, 213).withOpacity(0.5),
                    blurRadius: 8,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user["photoURL"] ?? ''),
                    backgroundColor: Colors.grey[800],
                    child: user["photoURL"] == ""
                        ? Icon(Icons.person, color: Color.fromARGB(255, 129, 34, 213))
                        : null,
                  ),
                  SizedBox(width: 15),
                  // User Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user["displayName"] ?? 'Anonymous',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          user["email"] ?? '',
                          style: TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  // Action (e.g., Start Chat)
                  IconButton(
                    icon: Icon(Icons.message, color: Color.fromARGB(255, 129, 34, 213)),
                    onPressed: () {
                      Get.snackbar(
                        "Chat",
                        "Starting chat with ${user["displayName"]}",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
