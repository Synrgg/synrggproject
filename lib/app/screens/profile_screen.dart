import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../controllers/profile_controller.dart';
import '../themes/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController controller = Get.put(ProfileController());
  final ImagePicker _picker = ImagePicker();

  Future<void> _requestPermissions() async {
    await [Permission.photos, Permission.storage].request();
  }

  Future<void> _pickImage() async {
    await _requestPermissions();
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      // You can upload the image here using your controller
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        title: DefaultTextStyle(
          style: const TextStyle(
            color: AppColors.primary,
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
                    colors: [AppColors.primary, AppColors.background],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: controller.imageUrls.isEmpty
                    ? const Center(
                  child: Text(
                    "No images uploaded. Tap the button to add images.",
                    style: TextStyle(
                        color: AppColors.text,
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
                            color: AppColors.primary, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.5),
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
                                    color: AppColors.error, fontSize: 16),
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
                      color: AppColors.primary, size: 40),
                  onPressed: _pickImage,
                ),
              ),

              // User Info Section
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.background, AppColors.subBackground],
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
                        border: Border.all(color: AppColors.primary, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.6),
                            blurRadius: 15,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        backgroundColor: AppColors.background,
                        radius: 40,
                        child: Icon(Icons.person,
                            size: 40, color: AppColors.primary),
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
                            color: AppColors.primary,
                            fontFamily: 'Orbitron',
                          ),
                        ),
                        const SizedBox(height: 5),
                        AnimatedTextKit(
                          animatedTexts: [
                            FadeAnimatedText(
                              "Welcome Back, Player!",
                              textStyle: const TextStyle(
                                color: AppColors.text,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Orbitron',
                              ),
                            ),
                            FadeAnimatedText(
                              "Gear Up for Action",
                              textStyle: const TextStyle(
                                color: AppColors.text,
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
                    color: AppColors.primary,
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
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.5),
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
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text("Rank: ${game["rank"]}",
                              style: const TextStyle(color: AppColors.text)),
                          Text("KDA: ${game["kda"]}",
                              style: const TextStyle(color: AppColors.text)),
                          Text("Matches: ${game["matches"]}",
                              style: const TextStyle(color: AppColors.text)),
                          Text("Winrate: ${game["winrate"]}",
                              style: const TextStyle(color: AppColors.text)),
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
