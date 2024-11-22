import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:synergee/app/data/services/firestore_user_service.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirestoreUserService _firestoreService = FirestoreUserService();

  var isSignedIn = false.obs;
  User? get user => _auth.currentUser;

  @override
  void onInit() {
    super.onInit();

    // Listen to authentication state changes
    _auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        isSignedIn.value = false;
        Get.offAllNamed('/onboarding'); // Navigate to Onboarding
      } else {
        isSignedIn.value = true;

        // Ensure user exists in Firestore
        await _firestoreService.createUserInFirestore(user);

        Get.offAllNamed('/home'); // Navigate to Home
      }
    });
  }

  Future<void> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await _firestoreService.createUserInFirestore(userCredential.user!);
      }

      Get.snackbar(
        "Login Success",
        "Welcome, ${userCredential.user?.displayName ?? "User"}!",
        snackPosition: SnackPosition.BOTTOM,
      );
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
      await _auth.signOut();

      isSignedIn.value = false;

      Get.snackbar("Logout", "You have been logged out",
          snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      Get.snackbar(
        "Logout Error",
        "An error occurred: ${error.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
