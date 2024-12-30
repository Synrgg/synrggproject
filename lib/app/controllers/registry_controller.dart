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
        // Navigate to Terms and Conditions
        Get.toNamed('/terms');
      };

    privacyRecognizer = TapGestureRecognizer()
      ..onTap = () {
        // Navigate to Privacy Policy
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
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (!agreesToTerms.value) {
      Get.snackbar('Error', 'You must agree to the Terms and Privacy Policy.');
      return;
    }

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'All fields are required.');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match.');
      return;
    }

    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'username': name},
      );

      if (response.user != null) {
        await _supabase.from('profiles').upsert({
          'id': response.user!.id,
          'name': name,
          'email': email,
          'updated_at': DateTime.now().toIso8601String(),
        });

        Get.snackbar('Success', 'Account created successfully!');
        Get.offAllNamed('/community');
      }
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    }
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
