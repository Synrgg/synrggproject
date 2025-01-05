import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
    '217397558295-qdf6p0o4hg37ovau3rs1ml8bush1c30i.apps.googleusercontent.com',
    serverClientId:
    '217397558295-l2v6mjc3buq3mco28guirgtgicssgcit.apps.googleusercontent.com',
  );

  var isSignedIn = false.obs;
  User? get user => _supabase.auth.currentUser;

  @override
  void onInit() {
    super.onInit();

    // Listen to authentication state changes
    _supabase.auth.onAuthStateChange.listen((event) async {
      switch (event.event) {
        case AuthChangeEvent.signedIn:
          isSignedIn.value = true;
          await saveUserToDatabase(event.session!.user);
          Get.offAllNamed('/home');
          break;
        case AuthChangeEvent.signedOut:
          isSignedIn.value = false;
          Get.offAllNamed('/onboarding');
          break;
        default:
          break;
      }
    });
  }

  /// Initialize Authentication State
  Future<void> initializeAuthState() async {
    final currentUser = _supabase.auth.currentUser;
    isSignedIn.value = currentUser != null;
    if (currentUser != null) {
      await saveUserToDatabase(currentUser);
    }
  }

  /// Login with Google and Save User
  Future<AuthResponse> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception("Google login was canceled by the user.");
      }

      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken == null || googleAuth.accessToken == null) {
        throw Exception("Invalid Google token.");
      }

      final response = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: googleAuth.idToken!,
        accessToken: googleAuth.accessToken!,
      );

      if (response.session != null) {
        await saveUserToDatabase(response.session!.user);
      }

      return response;
    } catch (e) {
      _showSnackbar("Login Error", e.toString());
      rethrow;
    }
  }

  /// Save User to Database
  Future<void> saveUserToDatabase(User user) async {
    try {
      final userData = {
        'id': user.id,
        'display_name': user.userMetadata?['name'] ?? 'Anonymous',
        'avatar_url': user.userMetadata?['avatar_url'],
        'last_seen': DateTime.now().toIso8601String(),
        'created_at': user.createdAt ?? DateTime.now().toIso8601String(),
        'email': user.email,
        'updated_at': DateTime.now().toIso8601String(),
      };

      await _supabase.from('profiles').upsert(userData);
      print('User saved successfully');
    } catch (e) {
      print('Error saving user: $e');
      _showSnackbar("Database Error", e.toString());
    }
  }

  /// Logout the User
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _supabase.auth.signOut();

      isSignedIn.value = false;
      _showSnackbar("Logout", "You have been logged out");
    } catch (e) {
      _showSnackbar("Logout Error", e.toString());
    }
  }

  /// Centralized Snackbar Helper
  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
