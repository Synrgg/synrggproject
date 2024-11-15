import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:synergee/app/controllers/auth_controller.dart';
import 'package:synergee/app/screens/home.dart';
import 'package:synergee/widgtes/background_painter.dart';
import 'package:synergee/widgtes/login_button.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.gamepad_outlined,
                    color: Colors.cyanAccent,
                    size: 100,
                  ),
                  const SizedBox(height: 24),

                  Text(
                    "Welcome, Gamer!",
                    style: GoogleFonts.orbitron(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent,
                    ),
                  ),
                  const SizedBox(height: 24),

                  TextField(
                    controller: controller.emailController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: Colors.black54,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon:
                          const Icon(Icons.email, color: Colors.white54),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Obx(() => TextField(
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordVisible.value,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: const TextStyle(color: Colors.white54),
                          filled: true,
                          fillColor: Colors.black54,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.white54),
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white54,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        ),
                      )),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: controller.forgotPassword,
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(color: Colors.cyanAccent),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Fixed login button with proper callback type
                  Obx(() => GamerLoginButton(
                        text:
                            controller.isLoading.value ? "Loading..." : "Login",
                        onPressed: controller.isLoading.value
                            ? () {} // Empty callback instead of null
                            : controller.login,
                      )),

                  const SizedBox(height: 16),

                  TextButton(
                    onPressed: () => Get.toNamed('/register'),
                    child: const Text(
                      "Not a member? Register now",
                      style: TextStyle(color: Colors.cyanAccent),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: const [
                      Expanded(child: Divider(color: Colors.white54)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.white54)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.google,
                            color: Colors.redAccent),
                        iconSize: 32,
                        onPressed: () async {
                          try {
                            await Get.find<AuthController>().loginWithGoogle();
                            if (Get.find<AuthController>().isSignedIn.value) {
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
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.apple,
                            color: Colors.white),
                        iconSize: 32,
                        onPressed: () {
                          // Apple sign-in action
                        },
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.xbox,
                            color: Colors.greenAccent),
                        iconSize: 32,
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
  }
}
