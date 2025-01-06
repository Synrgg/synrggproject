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
    _supabase.auth.onAuthStateChange.listen((event) {
      if (event.event == AuthChangeEvent.signedIn) {
        isSignedIn.value = true;
        Get.offAllNamed('/home');
      } else if (event.event == AuthChangeEvent.signedOut) {
        isSignedIn.value = false;
        Get.offAllNamed('/onboarding');
      }
    });
  }

  Future<AuthResponse> loginWithGoogle() async {
    const webClientId =
        '217397558295-l2v6mjc3buq3mco28guirgtgicssgcit.apps.googleusercontent.com';
    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    final response = await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken!,
      accessToken: accessToken,
    );
    await _storeUserDetails();

    return response;
  }

  Future<void> _storeUserDetails() async {
    try {
      final currentUser = user;
      if (currentUser != null && currentUser.email != null) {
        final existingUser = await _supabase
            .from('users')
            .select('id')
            .eq('email', currentUser.email!)
            .maybeSingle();

        if (existingUser == null) {
          await _supabase.from('users').insert({
            'id': currentUser.id,
            'name': currentUser.userMetadata?['name'] ?? currentUser.email,
            'email': currentUser.email,
            'created_at': DateTime.now().toIso8601String(),
          });
        } else {
          print("User already exists: ${currentUser.email}");
        }
      } else {
        throw Exception("User or email is null");
      }
    } catch (error) {
      Get.snackbar(
        "Error",
        "Failed to store user details: ${error.toString()}",
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
}
