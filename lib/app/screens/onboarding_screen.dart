import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synergee/widgtes/background_painter.dart';
import '../controllers/onboarding_controller.dart';
import '../routes/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gaming-themed Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF203A43),
                  Color(0xFF000000),
                ],
              ),
            ),
          ),
          // Background Overlay for Faint Gaming Elements (Grid, Shapes)
          CustomPaint(
            painter: GamingBackgroundPainter(),
            child: Container(),
          ),
          PageView(
            onPageChanged: controller.changePage,
            children: [
              buildOnboardingPage(
                context,
                "Watch videos seamlessly",
                "Continue",
                AppRoutes.LOGIN,
                isVideoPage: true,
              ),
              buildOnboardingPage(
                context,
                "Build your Synergy",
                "Get Started",
                AppRoutes.LOGIN,
                isVideoPage: false,
                subtitle:
                    "Track your progress across various games and show off your customizable profiles.",
              ),
            ],
          ),
          // Dot indicators for page navigation
          Positioned(
            bottom: 140,
            left: 0,
            right: 0,
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    width: controller.currentIndex.value == index ? 12 : 8,
                    height: controller.currentIndex.value == index ? 12 : 8,
                    decoration: BoxDecoration(
                      color: controller.currentIndex.value == index
                          ? Colors.white
                          : Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildOnboardingPage(
    BuildContext context,
    String title,
    String buttonText,
    String route, {
    required bool isVideoPage,
    String subtitle = "",
  }) {
    return Column(
      children: [
        Spacer(flex: 3),
        if (isVideoPage)
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.35,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                Icons.play_circle_fill,
                color: Colors.white,
                size: 80,
              ),
            ),
          ),
        if (!isVideoPage)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        Spacer(flex: 4),
        Padding(
          padding: const EdgeInsets.only(bottom: 40.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () => Get.toNamed(route),
              style: ElevatedButton.styleFrom(
                foregroundColor: Color(0xFF1F1C2C),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom painter for the gaming background
