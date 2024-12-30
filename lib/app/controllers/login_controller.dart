import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final SupabaseClient _supabase = Supabase.instance.client;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  String get email => emailController.text;
  String get password => passwordController.text;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login() async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and password');
      return;
    }

    try {
      isLoading.value = true;
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      if (response.session != null) {
        Get.snackbar('Success', 'Welcome back!');
        emailController.clear();
        passwordController.clear();
        Get.offAllNamed('/home');
      }
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter your email address');
      return;
    }

    try {
      await _supabase.auth.resetPasswordForEmail(email.trim());
      Get.snackbar('Success', 'Password reset email sent');
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message);
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred');
    }
  }
}
