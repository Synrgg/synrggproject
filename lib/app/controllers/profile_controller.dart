import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var username = ''.obs;
  var imageUrls = <String>[].obs;
  RxList<Map<String, String>> gamesData = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchUserImages();
    initializeDummyGamesData(); // Initialize dummy data first
    fetchGamesData(); // Fetch game data dynamically
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not logged in.");
      }

      username.value = user.displayName ?? "Guest";
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserImages() async {
    try {
      isLoading(true);
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not logged in.");
      }

      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (snapshot.exists && snapshot.data() != null) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (data.containsKey('imageUrls') && data['imageUrls'] != null) {
          imageUrls.value = List<String>.from(data['imageUrls']);
        }
      }
    } catch (e) {
      print("Error fetching user images: $e");
    } finally {
      isLoading(false);
    }
  }

  void initializeDummyGamesData() {
    gamesData.value = [
      {
        "name": "Valorant",
        "rank": "Diamond",
        "kda": "1.45",
        "matches": "200",
        "winrate": "60%"
      },
      {
        "name": "BGMI",
        "rank": "Ace",
        "kda": "4.5",
        "matches": "300",
        "winrate": "80%"
      },
      {
        "name": "CS:GO",
        "rank": "Global Elite",
        "kda": "2.0",
        "matches": "150",
        "winrate": "75%"
      },
      {
        "name": "Apex Legends",
        "rank": "Predator",
        "kda": "2.8",
        "matches": "220",
        "winrate": "70%"
      },
      {
        "name": "Call of Duty",
        "rank": "Master",
        "kda": "3.2",
        "matches": "180",
        "winrate": "68%"
      }
    ];
  }

  Future<void> fetchGamesData() async {
    try {
      isLoading(true);

      // Replace with your actual game API endpoint
      const apiUrl = 'https://api.example.com/games';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> gameList = json.decode(response.body);

        // Map the game data to a List<Map<String, String>>
        gamesData.value = gameList.map((game) {
          // Safely cast all dynamic values to String
          return {
            "name": game["name"]?.toString() ?? "Unknown",
            "rank": game["rank"]?.toString() ?? "N/A",
            "kda": game["kda"]?.toString() ?? "N/A",
            "matches": game["matches"]?.toString() ?? "0",
            "winrate": game["winrate"]?.toString() ?? "0%",
          };
        }).cast<Map<String, String>>().toList();
      } else {
        print("Failed to fetch game data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching games data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadImage(File imageFile) async {
    try {
      isLoading(true);
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        throw Exception("User not logged in.");
      }

      String userId = user.uid;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      String filePath = 'uploads/$userId/$fileName';

      print("Uploading file to: $filePath");

      // Upload the file to Firebase Storage
      UploadTask uploadTask =
      FirebaseStorage.instance.ref(filePath).putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print("File uploaded successfully. Download URL: $downloadUrl");

      // Save the URL to Firestore
      imageUrls.add(downloadUrl);
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'imageUrls': imageUrls,
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error uploading image: $e");
    } finally {
      isLoading(false);
    }
  }
}
