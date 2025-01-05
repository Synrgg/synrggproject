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
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: user['assets/images/avatar.jpg'] != null
                      ? NetworkImage(user['avatar_url'])
                      : null,
                  backgroundColor: Colors.grey[800],
                  child: user['avatar_url'] == null
                      ? Icon(Icons.person, color: Colors.white)
                      : null,
                ),
                title: Text(
                  user['display_name'] ?? 'Unknown',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Last seen: ${user['last_seen'] ?? 'Recently'}',
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: Icon(Icons.chat_bubble_outline,
                    color: Color.fromARGB(255, 129, 34, 213)),
                onTap: () {
                  // Handle chat navigation here
                },
              ),
            );
          },
        );
      }),
    );
  }
}
