import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../controllers/registry_controller.dart';
import '../themes/colors.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLogo(),
                      _buildTitle(),
                      _buildSubtitle(),
                      _buildNameField(controller),
                      _buildEmailField(controller),
                      _passwordSection(controller),
                      _termsAndConditionsSection(controller),
                      _proceedButton(controller),
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

  Widget _buildLogo() {
    return Image.asset(
      'assets/images/Logo.png',
      height: 40.h,
      width: 80.h,
    );
  }

  Widget _buildTitle() {
    return Text(
      "Sign up",
      style: GoogleFonts.orbitron(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildSubtitle() {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Text(
        "Create an account to get started",
        style: GoogleFonts.orbitron(
          fontSize: 14.sp,
          color: AppColors.subText,
        ),
      ),
    );
  }

  Widget _buildNameField(RegisterController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: SizedBox(
        width: 90.w,
        child: TextField(
          controller: controller.nameController,
          style: TextStyle(
            color: AppColors.text,
            fontSize: 16.sp,
          ),
          decoration: _buildInputDecoration(
            labelText: "Name",
            icon: Icons.person,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField(RegisterController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        width: 90.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: controller.emailController,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 16.sp,
              ),
              decoration: _buildInputDecoration(
                labelText: "Email Address",
                icon: Icons.email,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.w, top: 0.5.h),
              child: Text(
                "( Use same Email Address on which Game account Exists)",
                style: TextStyle(
                  color: AppColors.subText,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordSection(RegisterController controller) {
    return Column(
      children: [
        Obx(() => _buildPasswordField(
          controller: controller.passwordController,
          labelText: "Create a password",
          isVisible: controller.isPasswordVisible.value,
          onToggle: controller.togglePasswordVisibility,
        )),
        Obx(() => _buildPasswordField(
          controller: controller.confirmPasswordController,
          labelText: "Confirm password",
          isVisible: controller.isConfirmPasswordVisible.value,
          onToggle: controller.toggleConfirmPasswordVisibility,
        )),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String labelText,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        width: 90.w,
        child: TextField(
          controller: controller,
          obscureText: !isVisible,
          style: TextStyle(
            color: AppColors.text,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: AppColors.subText,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: AppColors.inputBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: AppColors.icon,
              size: 20.sp,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColors.icon,
                size: 20.sp,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _termsAndConditionsSection(RegisterController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        width: 90.w,
        child: Row(
          children: [
            Obx(() => Checkbox(
              value: controller.agreesToTerms.value,
              onChanged: (value) {
                controller.agreesToTerms.value = value ?? false;
              },
              fillColor: MaterialStateProperty.all(AppColors.primary),
            )),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 12.sp,
                  ),
                  children: [
                    const TextSpan(text: "I've read and agree with the "),
                    TextSpan(
                      text: "Terms and Conditions",
                      style: const TextStyle(color: AppColors.primary),
                      recognizer: controller.termsRecognizer,
                    ),
                    const TextSpan(text: " and the "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: const TextStyle(color: AppColors.primary),
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
    );
  }

  Widget _proceedButton(RegisterController controller) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: SizedBox(
        width: 90.w,
        height: 6.h,
        child: ElevatedButton(
          onPressed: controller.register,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'PROCEED',
            style: TextStyle(
              color: AppColors.text,
              fontFamily: 'Orbitron',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: AppColors.subText,
        fontSize: 14.sp,
      ),
      filled: true,
      fillColor: AppColors.inputBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(
        icon,
        color: AppColors.icon,
        size: 20.sp,
      ),
    );
  }
}
