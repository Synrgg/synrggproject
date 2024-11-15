import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart'; // Import ResponsiveSizer
import 'package:synergee/widgtes/background_painter.dart';
import '../controllers/onboarding_controller.dart';
import '../routes/app_routes.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          body: Stack(
            children: [
              // Gaming-themed Background
              Container(
                decoration: const BoxDecoration(
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
                bottom: 18.h, // Responsive spacing from the bottom
                left: 0,
                right: 0,
                child: Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 1.w), // Responsive margin
                        width:
                            controller.currentIndex.value == index ? 3.w : 2.w,
                        height:
                            controller.currentIndex.value == index ? 3.w : 2.w,
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
      },
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w), // Responsive padding
      child: Column(
        children: [
          Spacer(flex: 3),
          if (isVideoPage)
            Container(
              width: 80.w, // Responsive width
              height: 35.h, // Responsive height
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 10.w, // Responsive icon size
                ),
              ),
            ),
          if (!isVideoPage)
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 4.w), // Responsive padding
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 2.h), // Responsive top padding
                    child: Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp, // Responsive font size
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Spacer(flex: 4),
          Padding(
            padding: EdgeInsets.only(bottom: 5.h), // Responsive bottom padding
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(route),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xFF1F1C2C),
                  backgroundColor: Colors.white,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: Text(
                  buttonText,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp, // Responsive font size
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
