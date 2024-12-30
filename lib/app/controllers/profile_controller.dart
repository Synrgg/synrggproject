import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;

  var isLoading = true.obs;
  var username = ''.obs;
  var imageUrls = <String>[].obs;
  RxList<Map<String, String>> gamesData = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchUserImages();
    initializeDummyGamesData();
    fetchGamesData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in.");
      }
      username.value = user.userMetadata?['username'] ?? "Guest";
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserImages() async {
    try {
      isLoading(true);
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in.");
      }

      final data = await _supabase
          .from('profiles')
          .select('image_urls')
          .eq('id', user.id)
          .single();

      imageUrls.value = List<String>.from(data['image_urls'] ?? []);
    } catch (e) {
      Get.snackbar('Error', e.toString());
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
        gamesData.value = gameList
            .map((game) {
              // Safely cast all dynamic values to String
              return {
                "name": game["name"]?.toString() ?? "Unknown",
                "rank": game["rank"]?.toString() ?? "N/A",
                "kda": game["kda"]?.toString() ?? "N/A",
                "matches": game["matches"]?.toString() ?? "0",
                "winrate": game["winrate"]?.toString() ?? "0%",
              };
            })
            .cast<Map<String, String>>()
            .toList();
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
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in.");
      }

      final filePath =
          'profile/${user.id}/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await _supabase.storage.from('media').upload(filePath, imageFile);
      final imageUrl = _supabase.storage.from('media').getPublicUrl(filePath);
      imageUrls.add(imageUrl);

      await _supabase
          .from('profiles')
          .update({'image_urls': imageUrls}).eq('id', user.id);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
