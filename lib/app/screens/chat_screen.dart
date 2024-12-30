import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synergee/app/screens/home.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

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
          icon: const Icon(Icons.arrow_back, color: Color.fromARGB(255, 129, 34, 213)),
          onPressed: () {
            Get.offAll(() => HomePage());

          },
        ),
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: chatController.searchText.isEmpty
              ? const Row(
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
            key: const ValueKey("search"),
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Search users...',
              hintStyle: TextStyle(color: Colors.white54),
              border: InputBorder.none,
            ),
            style: const TextStyle(color: Colors.white, fontSize: 18),
            onChanged: (value) {
              chatController.updateSearchText(value);
            },
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              chatController.searchText.isEmpty ? Icons.search : Icons.close,
              color: const Color.fromARGB(255, 129, 34, 213),
            ),
            onPressed: () {
              chatController.toggleSearch();
            },
          ),
          IconButton(
            icon: const Icon(Icons.group, color: Color.fromARGB(255, 129, 34, 213)),
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
          return const Center(
            child: CircularProgressIndicator(color: Color.fromARGB(255, 129, 34, 213)),
          );
        }

        if (chatController.filteredUsers.isEmpty) {
          return const Center(
            child: Text(
              'No users found.',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: chatController.filteredUsers.length,
          itemBuilder: (context, index) {
            final user = chatController.filteredUsers[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 129, 34, 213).withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
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
                        ? const Icon(Icons.person, color: Color.fromARGB(255, 129, 34, 213))
                        : null,
                  ),
                  const SizedBox(width: 15),
                  // User Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user["displayName"] ?? 'Anonymous',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          user["email"] ?? '',
                          style: const TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  // Action (e.g., Start Chat)
                  IconButton(
                    icon: const Icon(Icons.message, color: Color.fromARGB(255, 129, 34, 213)),
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
