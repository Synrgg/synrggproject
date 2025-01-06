import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_controller.dart';
import 'home.dart'; // Import your HomePage class

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 129, 34, 213),
          ),
          onPressed: () {
            Get.offAll(() => HomePage()); // Navigate back to the homepage
          },
        ),
        title: Text(
          'Inbox',
          style: TextStyle(
            color: Color.fromARGB(255, 129, 34, 213),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Obx(() {
        if (chatController.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 129, 34, 213),
            ),
          );
        }

        if (chatController.allUsers.isEmpty) {
          return Center(
            child: Text(
              'No users found.',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          );
        }

        return ListView.builder(
          itemCount: chatController.allUsers.length,
          itemBuilder: (context, index) {
            final user = chatController.allUsers[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 129, 34, 213),
                child: Text(
                  user['name'] != null && user['name'].isNotEmpty
                      ? user['name'][0].toUpperCase()
                      : '?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                user['name'] ?? 'Unknown',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              subtitle: Text(
                user['email'] ?? 'No email',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.message,
                  color: Color.fromARGB(255, 129, 34, 213),
                ),
                onPressed: () {
                  Get.snackbar('Chat', 'Start chatting with ${user['name']}!',
                      snackPosition: SnackPosition.BOTTOM,
                      colorText: Colors.white,
                      backgroundColor: Colors.black87);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
