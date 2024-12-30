import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synergee/app/data/services/supabase_user_service.dart';

class AuthController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  final SupabaseUserService _userService = SupabaseUserService();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    // clientId:
    //     '217397558295-qdf6p0o4hg37ovau3rs1ml8bush1c30i.apps.googleusercontent.com',
    serverClientId:
        '217397558295-l2v6mjc3buq3mco28guirgtgicssgcit.apps.googleusercontent.com', // Web Client ID
  );

  var isSignedIn = false.obs;
  User? get user => _supabase.auth.currentUser;

  @override
  void onInit() {
    super.onInit();

    // Listen to authentication state changes
    _supabase.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn) {
        isSignedIn.value = true;
        saveUserToDatabase(event.session!.user);

        Get.offAllNamed('/home'); // Navigate to Home
      } else if (event.event == AuthChangeEvent.signedOut) {
        isSignedIn.value = false;
        Get.offAllNamed('/onboarding'); // Navigate to Onboarding
      }
    });
  }

  Future<void> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        throw 'Authentication failed: Missing tokens.';
      }

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (response.session != null) {
        saveUserToDatabase(response.session!.user);

        Get.snackbar(
          "Login Success",
          "Welcome, ${response.user?.email ?? "User"}!",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (error) {
      Get.snackbar(
        "Login Error",
        "An error occurred: ${error.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _supabase.auth.signOut();

      isSignedIn.value = false;

      Get.snackbar(
        "Logout",
        "You have been logged out",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      Get.snackbar(
        "Logout Error",
        "An error occurred: ${error.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> saveUserToDatabase(User user) async {
    try {
      await _userService.createUser(user);
      Get.snackbar(
        "User Synced",
        "User information has been updated in the database",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      Get.snackbar(
        "Sync Error",
        "An error occurred while saving user: ${error.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
