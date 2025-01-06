import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());
  final ImagePicker _picker = ImagePicker();

  // Request permissions
  Future<void> _requestPermissions() async {
    await [
      Permission.photos,
      Permission.storage,
    ].request();
  }

  // Pick image from gallery
  Future<void> _pickImage() async {
    await _requestPermissions();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      // await controller.uploadImage(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: DefaultTextStyle(
          style: const TextStyle(
            color: Color.fromARGB(255, 129, 34, 213),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Orbitron',
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText('Gaming Profile',
                  duration: const Duration(seconds: 2)),
              RotateAnimatedText('Player Zone',
                  duration: const Duration(seconds: 2)),
              RotateAnimatedText('Ready to Play?',
                  duration: const Duration(seconds: 2)),
            ],
            repeatForever: true,
          ),
        ),
        elevation: 8,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Slideshow Section
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color.fromARGB(255, 129, 34, 213), Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: controller.imageUrls.isEmpty
                    ? const Center(
                        child: Text(
                          "No images uploaded. Tap the button to add images.",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'Orbitron'),
                        ),
                      )
                    : PageView.builder(
                        itemCount: controller.imageUrls.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 129, 34, 213),
                                  width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 129, 34, 213)
                                      .withOpacity(0.5),
                                  blurRadius: 15,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                controller.imageUrls[index],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Text(
                                      "Failed to load image",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  icon: const Icon(Icons.camera_alt,
                      color: Color.fromARGB(255, 129, 34, 213), size: 40),
                  onPressed: _pickImage,
                ),
              ),

              // User Info Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.grey[850]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: const Color.fromARGB(255, 129, 34, 213),
                            width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 129, 34, 213)
                                .withOpacity(0.6),
                            blurRadius: 15,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 40,
                        child: Icon(Icons.person,
                            size: 40, color: Color.fromARGB(255, 129, 34, 213)),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.username.value,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 129, 34, 213),
                            fontFamily: 'Orbitron',
                          ),
                        ),
                        const SizedBox(height: 5),
                        AnimatedTextKit(
                          animatedTexts: [
                            FadeAnimatedText(
                              "Welcome Back, Player!",
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Orbitron',
                              ),
                            ),
                            FadeAnimatedText(
                              "Gear Up for Action",
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Orbitron',
                              ),
                            ),
                          ],
                          repeatForever: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Game Data Section
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Games Data",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 129, 34, 213),
                    fontFamily: 'Orbitron',
                  ),
                ),
              ),
              ListView.builder(
                itemCount: controller.gamesData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final game = controller.gamesData[index];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 129, 34, 213),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 129, 34, 213)
                              .withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            game["name"]!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("Rank: ${game["rank"]}",
                              style: const TextStyle(color: Colors.white)),
                          Text("KDA: ${game["kda"]}",
                              style: const TextStyle(color: Colors.white)),
                          Text("Matches: ${game["matches"]}",
                              style: const TextStyle(color: Colors.white)),
                          Text("Winrate: ${game["winrate"]}",
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
