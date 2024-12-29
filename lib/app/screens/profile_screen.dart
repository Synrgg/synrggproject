import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
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
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await controller.uploadImage(imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: DefaultTextStyle(
          style: TextStyle(
            color: Color.fromARGB(255, 129, 34, 213),
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Orbitron',
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText('Gaming Profile', duration: Duration(seconds: 2)),
              RotateAnimatedText('Player Zone', duration: Duration(seconds: 2)),
              RotateAnimatedText('Ready to Play?', duration: Duration(seconds: 2)),
            ],
            repeatForever: true,
          ),
        ),
        elevation: 8,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.fetchUserImages,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Slideshow Section
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 129, 34, 213), Colors.black],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: controller.imageUrls.isEmpty
                      ? Center(
                    child: Text(
                      "No images uploaded. Tap the button to add images.",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'Orbitron'),
                    ),
                  )
                      : PageView.builder(
                    itemCount: controller.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Color.fromARGB(255, 129, 34, 213), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 129, 34, 213).withOpacity(0.5),
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
                              return Center(
                                child: Text(
                                  "Failed to load image",
                                  style: TextStyle(color: Colors.red, fontSize: 16),
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
                    icon: Icon(Icons.camera_alt, color: Color.fromARGB(255, 129, 34, 213), size: 40),
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
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Color.fromARGB(255, 129, 34, 213), width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 129, 34, 213).withOpacity(0.6),
                              blurRadius: 15,
                              spreadRadius: 3,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 40,
                          child: Icon(Icons.person, size: 40, color: Color.fromARGB(255, 129, 34, 213)),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.username.value,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 129, 34, 213),
                              fontFamily: 'Orbitron',
                            ),
                          ),
                          SizedBox(height: 5),
                          AnimatedTextKit(
                            animatedTexts: [
                              FadeAnimatedText(
                                "Welcome Back, Player!",
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Orbitron',
                                ),
                              ),
                              FadeAnimatedText(
                                "Gear Up for Action",
                                textStyle: TextStyle(
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
                Padding(
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
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final game = controller.gamesData[index];
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 129, 34, 213),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 129, 34, 213).withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              game["name"]!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Rank: ${game["rank"]}", style: TextStyle(color: Colors.white)),
                            Text("KDA: ${game["kda"]}", style: TextStyle(color: Colors.white)),
                            Text("Matches: ${game["matches"]}", style: TextStyle(color: Colors.white)),
                            Text("Winrate: ${game["winrate"]}", style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
