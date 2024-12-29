import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:synergee/app/screens/chat_screen.dart';
import 'package:synergee/app/screens/community.dart';
import 'package:synergee/app/screens/home.dart';
import '../app/controllers/community_screen_controller.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final CommunityScreenController controller;

  const CustomBottomNavigationBar({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.selectedIndex.value,
        onTap: (index) {
          controller.changeTab(index);
          switch (index) {
            case 0:
              Get.offAll(() => HomePage());
              break;
            case 1:
              Get.offAll(() => CommunityScreen());
              break;
            case 2:
              // new logic
              break;
            case 3:
              Get.snackbar("Coming Soon", "This feature is under development");
              break;
            case 4:
              // Add logic for the "Chat" icon
              Get.offAll(() => ChatScreen());

              break;
            default:
              break;
          }
        },
        backgroundColor: Colors.grey[900],
        selectedItemColor: const Color.fromARGB(255, 129, 34, 213),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'New',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volume_up),
            label: 'Voice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
