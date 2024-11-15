import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:synergee/app/controllers/registry_controller.dart';
import 'package:synergee/widgtes/background_painter.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({Key? key}) : super(key: key);

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
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.gamepad_outlined,
                        color: Colors.cyanAccent,
                        size: 15.w,
                      ),
                      SizedBox(height: 3.h),
                      Text(
                        "Sign up",
                        style: GoogleFonts.orbitron(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        "Create an account to get started",
                        style: GoogleFonts.orbitron(
                          fontSize: 14.sp,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        width: 90.w,
                        child: TextField(
                          controller: controller.nameController,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            labelText: "Name",
                            labelStyle: TextStyle(
                              color: Colors.white54,
                              fontSize: 14.sp,
                            ),
                            filled: true,
                            fillColor: Colors.black54,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white54,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 2.h),

                      // Email field with subtitle
                      Container(
                        width: 90.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: controller.emailController,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                              decoration: InputDecoration(
                                labelText: "Email Address",
                                labelStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14.sp,
                                ),
                                filled: true,
                                fillColor: Colors.black54,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.white54,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 3.w, top: 0.5.h),
                              child: Text(
                                "( Use same Email Address on which Game account Exists)",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h),

                      // Password field
                      Container(
                        width: 90.w,
                        child: Obx(() => TextField(
                              controller: controller.passwordController,
                              obscureText: !controller.isPasswordVisible.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                              decoration: InputDecoration(
                                labelText: "Create a password",
                                labelStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14.sp,
                                ),
                                filled: true,
                                fillColor: Colors.black54,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white54,
                                  size: 20.sp,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white54,
                                    size: 20.sp,
                                  ),
                                  onPressed:
                                      controller.togglePasswordVisibility,
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 2.h),

                      // Confirm Password field
                      Container(
                        width: 90.w,
                        child: Obx(() => TextField(
                              controller: controller.confirmPasswordController,
                              obscureText:
                                  !controller.isConfirmPasswordVisible.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                              decoration: InputDecoration(
                                labelText: "Confirm password",
                                labelStyle: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 14.sp,
                                ),
                                filled: true,
                                fillColor: Colors.black54,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white54,
                                  size: 20.sp,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    controller.isConfirmPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white54,
                                    size: 20.sp,
                                  ),
                                  onPressed: controller
                                      .toggleConfirmPasswordVisibility,
                                ),
                              ),
                            )),
                      ),
                      SizedBox(height: 2.h),

                      // Terms and Privacy Policy
                      Container(
                        width: 90.w,
                        child: Row(
                          children: [
                            Obx(() => Transform.scale(
                                  scale: 1.2,
                                  child: Checkbox(
                                    value: controller.agreesToTerms.value,
                                    onChanged: (value) => controller
                                        .agreesToTerms.value = value ?? false,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                      (states) => states
                                              .contains(MaterialState.selected)
                                          ? Colors.cyanAccent
                                          : Colors.white54,
                                    ),
                                  ),
                                )),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                  ),
                                  children: [
                                    const TextSpan(
                                        text: "I've read and agree with the "),
                                    TextSpan(
                                      text: "Terms and Conditions",
                                      style:
                                          const TextStyle(color: Colors.blue),
                                      recognizer: controller.termsRecognizer,
                                    ),
                                    const TextSpan(text: " and the "),
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style:
                                          const TextStyle(color: Colors.blue),
                                      recognizer: controller.privacyRecognizer,
                                    ),
                                    const TextSpan(text: "."),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),

                      // Proceed Button
                      Container(
                        width: 90.w,
                        height: 6.h,
                        child: ElevatedButton(
                          onPressed: controller.register,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            'Proceed',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
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
