import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart'; // Import ResponsiveSizer
import 'package:synergee/app/controllers/auth_controller.dart';
import 'package:synergee/app/screens/home.dart';
import 'package:synergee/widgtes/background_painter.dart';
import 'package:synergee/widgtes/login_button.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF0F2027),
                      Color(0xFF203A43),
                      Color(0xFF2C5364),
                    ],
                  ),
                ),
              ),
              CustomPaint(
                painter: GamingBackgroundPainter(),
                child: Container(),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 5.w), // Responsive padding
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.gamepad_outlined,
                        color: Colors.cyanAccent,
                        size: 15.w, // Responsive icon size
                      ),
                      SizedBox(height: 3.h), // Responsive spacing

                      Text(
                        "Welcome, Gamer!",
                        style: GoogleFonts.orbitron(
                          fontSize: 22.sp, // Responsive font size
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent,
                        ),
                      ),
                      SizedBox(height: 3.h),

                      TextField(
                        controller: controller.emailController,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        decoration: InputDecoration(
                          labelText: "Email Address",
                          labelStyle:
                              TextStyle(color: Colors.white54, fontSize: 14.sp),
                          filled: true,
                          fillColor: Colors.black54,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.email,
                              color: Colors.white54, size: 18.sp),
                        ),
                      ),
                      SizedBox(height: 2.h),

                      Obx(() => TextField(
                            controller: controller.passwordController,
                            obscureText: !controller.isPasswordVisible.value,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.sp),
                            decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  color: Colors.white54, fontSize: 14.sp),
                              filled: true,
                              fillColor: Colors.black54,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Icon(Icons.lock,
                                  color: Colors.white54, size: 18.sp),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.isPasswordVisible.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white54,
                                  size: 18.sp,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                            ),
                          )),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: controller.forgotPassword,
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Colors.cyanAccent, fontSize: 14.sp),
                          ),
                        ),
                      ),

                      SizedBox(height: 3.h),

                      Obx(() => GamerLoginButton(
                            text: controller.isLoading.value
                                ? "Loading..."
                                : "Login",
                            onPressed: controller.isLoading.value
                                ? () {}
                                : controller.login,
                          )),

                      SizedBox(height: 2.h),

                      TextButton(
                        onPressed: () => Get.toNamed('/register'),
                        child: Text(
                          "Not a member? Register now",
                          style: TextStyle(
                              color: Colors.cyanAccent, fontSize: 14.sp),
                        ),
                      ),

                      SizedBox(height: 2.h),

                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white54)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.w),
                            child: Text(
                              "Or continue with",
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 12.sp),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white54)),
                        ],
                      ),
                      SizedBox(height: 2.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.google,
                                color: Colors.redAccent),
                            iconSize: 5.w,
                            onPressed: () async {
                              try {
                                await Get.find<AuthController>()
                                    .loginWithGoogle();
                                if (Get.find<AuthController>()
                                    .isSignedIn
                                    .value) {
                                  Get.offAll(() => HomePage());
                                }
                              } catch (e) {
                                Get.snackbar(
                                  "Error",
                                  "Failed to sign in with Google",
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            },
                          ),
                          SizedBox(width: 5.w),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.apple,
                                color: Colors.white),
                            iconSize: 5.w,
                            onPressed: () {
                              // Apple sign-in action
                            },
                          ),
                          SizedBox(width: 5.w),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.xbox,
                                color: Colors.greenAccent),
                            iconSize: 5.w,
                            onPressed: () {
                              // Game ID sign-in action
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
