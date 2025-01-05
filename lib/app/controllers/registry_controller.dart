import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final agreesToTerms = false.obs;

  late final TapGestureRecognizer termsRecognizer;
  late final TapGestureRecognizer privacyRecognizer;

  @override
  void onInit() {
    super.onInit();
    termsRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Get.toNamed('/terms');
      };

    privacyRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Get.toNamed('/privacy');
      };
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> register() async {
    try {
      if (!_validateInputs()) return;
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'name': name,
          'avatar_url': null,
        },
      );

      Get.back();

      if (response.user != null) {
        if (response.session == null) {
          Get.snackbar(
            'Verification Required',
            'Please check your email to verify your account before logging in.',
            duration: const Duration(seconds: 5),
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          Get.offAllNamed('/login');
        } else {
          try {
            await _supabase.from('users').insert({
              'id': response.user!.id,
              'name': name,
              'email': email,
              'avatar_url': null,
            });

            Get.snackbar(
              'Success',
              'Account created successfully!',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            Get.offAllNamed('/home');
          } catch (e) {
            print('Error creating user profile: $e');
            Get.snackbar(
              'Warning',
              'Account created but profile setup failed. Please update your profile later.',
              backgroundColor: Colors.orange,
              colorText: Colors.white,
            );
          }
        }
      }
    } on AuthException catch (e) {
      Get.snackbar(
        'Registration Error',
        e.message,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bool _validateInputs() {
    if (!agreesToTerms.value) {
      Get.snackbar('Error', 'You must agree to the Terms and Privacy Policy.');
      return false;
    }

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'All fields are required.');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match.');
      return false;
    }

    if (password.length < 6) {
      Get.snackbar('Error', 'Password must be at least 6 characters long.');
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    termsRecognizer.dispose();
    privacyRecognizer.dispose();
    super.onClose();
  }
}
