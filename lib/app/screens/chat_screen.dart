import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import '../themes/colors.dart';
import 'chat_page.dart'; // Import ChatPage
import 'home.dart'; // Import HomePage

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  bool isSearchActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () {
            Get.offAll(() => HomePage());
          },
        ),
        title: isSearchActive
            ? TextField(
          controller: searchController,
          autofocus: true,
          style: const TextStyle(color: AppColors.text),
          cursorColor: AppColors.primary,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: AppColors.subText),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            searchQuery.value = value;
          },
        )
            : const Text(
          'Inbox',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (!isSearchActive)
            IconButton(
              icon: const Icon(Icons.search, color: AppColors.primary),
              onPressed: () {
                setState(() {
                  isSearchActive = true;
                });
              },
            ),
          if (isSearchActive)
            IconButton(
              icon: const Icon(Icons.close, color: AppColors.text),
              onPressed: () {
                setState(() {
                  isSearchActive = false;
                  searchController.clear();
                  searchQuery.value = '';
                });
              },
            ),
        ],
      ),
      body: Obx(() {
        final filteredUsers = chatController.allUsers
            .where((user) =>
        user['name']
            ?.toLowerCase()
            ?.contains(searchQuery.value.toLowerCase()) ??
            false)
            .toList();

        if (chatController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        if (filteredUsers.isEmpty) {
          return const Center(
            child: Text(
              'No users found.',
              style: TextStyle(color: AppColors.subText, fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final user = filteredUsers[index];
            final lastMessage =
            (user['messages'] != null && user['messages'] is Map)
                ? user['messages']['content'] ?? 'No messages yet'
                : 'No messages yet';
            final lastMessageTime =
            (user['messages'] != null && user['messages'] is Map)
                ? user['messages']['created_at'] ?? ''
                : '';

            return Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8),
                leading: CircleAvatar(
                  backgroundColor: AppColors.primary,
                  radius: 25,
                  backgroundImage: user['photoURL'] != null
                      ? NetworkImage(user['photoURL'])
                      : null,
                  child: user['photoURL'] == null
                      ? Text(
                    user['name'] != null && user['name'].isNotEmpty
                        ? user['name'][0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                        color: AppColors.text, fontSize: 20),
                  )
                      : null,
                ),
                title: Text(
                  user['name'] ?? 'Unknown',
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lastMessage,
                      style: const TextStyle(
                        color: AppColors.subText,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (lastMessageTime.isNotEmpty)
                      Text(
                        lastMessageTime,
                        style: const TextStyle(
                          color: AppColors.subText,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  Get.to(
                        () => ChatPage(
                      chatId: user['chat_id'] ?? '',
                      userId: user['id'],
                      displayName: user['name'],
                      photoURL: user['photoURL'],
                    ),
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
