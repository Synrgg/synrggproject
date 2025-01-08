import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:synergee/app/controllers/auth_controller.dart';
import 'package:synergee/app/screens/community.dart';
import 'package:synergee/widgtes/login_button.dart';
import '../controllers/login_controller.dart';
import '../themes/colors.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h, top: 5.h),
                      child: Image.asset(
                        'assets/images/Logo.png',
                        width: 90.w,
                        height: 30.h,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Text(
                        "Welcome!",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.orbitron(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary, // Primary color
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: TextField(
                        controller: controller.emailController,
                        style: TextStyle(
                          color: AppColors.text, // Text color
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          labelStyle: TextStyle(
                            color: AppColors.subText, // Subtext color
                            fontSize: 14.sp,
                          ),
                          filled: true,
                          fillColor: AppColors.inputBackground, // Input background color
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.h),
                            borderSide: BorderSide(
                                color: AppColors.primary, // Primary color
                                width: 1.h),
                          ),
                          prefixIcon: Icon(
                            Icons.email,
                            color: AppColors.subText, // Subtext color
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.h),
                      child: Obx(
                            () => TextField(
                          controller: controller.passwordController,
                          obscureText: !controller.isPasswordVisible.value,
                          style: TextStyle(
                            color: AppColors.text, // Text color
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: AppColors.subText, // Subtext color
                              fontSize: 14.sp,
                            ),
                            filled: true,
                            fillColor: AppColors.inputBackground, // Input background color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.h),
                              borderSide: BorderSide(
                                color: AppColors.primary, // Primary color
                                width: 1.h,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: AppColors.subText, // Subtext color
                              size: 18.sp,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColors.subText, // Subtext color
                                size: 18.sp,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: TextButton(
                          onPressed: controller.forgotPassword,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: AppColors.primary, // Primary color
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Obx(
                            () => GamerLoginButton(
                          text: controller.isLoading.value
                              ? "Loading..."
                              : "Login",
                          onPressed: controller.isLoading.value
                              ? () {}
                              : controller.login,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: TextButton(
                        onPressed: () => Get.toNamed('/register'),
                        child: Text(
                          "Not a member? Register now",
                          style: TextStyle(
                            color: AppColors.primary, // Primary color
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 2.h),
                      child: Row(
                        children: [
                          const Expanded(child: Divider(color: AppColors.divider)), // Divider color
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Text(
                              "Or continue with",
                              style: TextStyle(
                                color: AppColors.subText, // Subtext color
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          const Expanded(child: Divider(color: AppColors.divider)), // Divider color
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                          child: IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.google,
                              color: AppColors.google, // Google color
                            ),
                            iconSize: 5.w,
                            onPressed: () async {
                              try {
                                await Get.find<AuthController>()
                                    .loginWithGoogle();
                                if (Get.find<AuthController>().isSignedIn.value) {
                                  Get.offAll(() => CommunityScreen());
                                }
                              } catch (e) {
                                Get.snackbar(
                                  "Error",
                                  "Failed to sign in with Google: $e",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                          child: IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.apple,
                              color: AppColors.apple, // Apple color
                            ),
                            iconSize: 5.w,
                            onPressed: () {
                              // Apple sign-in action
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.5.w),
                          child: IconButton(
                            icon: const FaIcon(
                              FontAwesomeIcons.xbox,
                              color: AppColors.xbox, // Xbox color
                            ),
                            iconSize: 5.w,
                            onPressed: () {
                              // Xbox sign-in action
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
