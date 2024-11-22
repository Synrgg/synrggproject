import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:synergee/app/controllers/registry_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.find<RegisterController>();
    final ThemeData theme = Theme.of(context);

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
                      _buildLogo(theme),
                      _buildTitle(theme),
                      _buildSubtitle(theme),
                      _buildNameField(controller, theme),
                      _buildEmailField(controller, theme),
                      _passwordSection(controller, theme),
                      _termsAndConditionsSection(controller, theme),
                      _proceedButton(controller, theme),
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

  Widget _buildLogo(ThemeData theme) {
    return Image.asset(
      'assets/images/Logo.png',
      height: 40.h,
      width: 80.h,
    );
  }

  Widget _buildTitle(ThemeData theme) {
    return Text(
      "Sign up",
      style: GoogleFonts.orbitron(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 129, 34, 213),
      ),
    );
  }

  Widget _buildSubtitle(ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Text(
        "Create an account to get started",
        style: GoogleFonts.orbitron(
          fontSize: 14.sp,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildNameField(RegisterController controller, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: SizedBox(
        width: 90.w,
        child: TextField(
          controller: controller.nameController,
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 16.sp,
          ),
          decoration: _buildInputDecoration(theme,
              labelText: "Name", icon: Icons.person),
        ),
      ),
    );
  }

  Widget _buildEmailField(RegisterController controller, ThemeData theme) {
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
                color: theme.textTheme.bodyLarge?.color,
                fontSize: 16.sp,
              ),
              decoration: _buildInputDecoration(theme,
                  labelText: "Email Address", icon: Icons.email),
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.w, top: 0.5.h),
              child: Text(
                "( Use same Email Address on which Game account Exists)",
                style: TextStyle(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _passwordSection(RegisterController controller, ThemeData theme) {
    return Column(
      children: [
        Obx(() => _buildPasswordField(
              context: Get.context!,
              controller: controller.passwordController,
              labelText: "Create a password",
              isVisible: controller.isPasswordVisible.value,
              onToggle: controller.togglePasswordVisibility,
              theme: theme,
            )),
        Obx(() => _buildPasswordField(
              context: Get.context!,
              controller: controller.confirmPasswordController,
              labelText: "Confirm password",
              isVisible: controller.isConfirmPasswordVisible.value,
              onToggle: controller.toggleConfirmPasswordVisibility,
              theme: theme,
            )),
      ],
    );
  }

  Widget _buildPasswordField({
    required BuildContext context,
    required TextEditingController controller,
    required String labelText,
    required bool isVisible,
    required VoidCallback onToggle,
    required ThemeData theme,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        width: 90.w,
        child: TextField(
          controller: controller,
          obscureText: !isVisible,
          style: TextStyle(
            color: theme.textTheme.bodyLarge?.color,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: theme.colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: theme.iconTheme.color,
              size: 20.sp,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: theme.iconTheme.color,
                size: 20.sp,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ),
    );
  }

  Widget _termsAndConditionsSection(
      RegisterController controller, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(top: 2.h),
      child: SizedBox(
        width: 90.w,
        child: Row(
          children: [
            Obx(() => Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    value: controller.agreesToTerms.value,
                    onChanged: (value) {
                      controller.agreesToTerms.value = value ?? false;
                    },
                    fillColor: WidgetStateProperty.resolveWith(
                      (states) {
                        return states.contains(WidgetState.selected)
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.onSurfaceVariant;
                      },
                    ),
                  ),
                )),
            Expanded(
              child: Text.rich(
                TextSpan(
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 12.sp,
                  ),
                  children: [
                    const TextSpan(text: "I've read and agree with the "),
                    TextSpan(
                      text: "Terms and Conditions",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 129, 34, 213)),
                      recognizer: controller.termsRecognizer,
                    ),
                    const TextSpan(text: " and the "),
                    TextSpan(
                      text: "Privacy Policy",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 129, 34, 213)),
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

  Widget _proceedButton(RegisterController controller, ThemeData theme) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: SizedBox(
        width: 90.w,
        height: 6.h,
        child: ElevatedButton(
          onPressed: controller.register,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 129, 34, 213),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'PROCEED',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Orbitron',
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(
    ThemeData theme, {
    required String labelText,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: theme.colorScheme.onSurfaceVariant,
        fontSize: 14.sp,
      ),
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      prefixIcon: Icon(
        icon,
        color: theme.iconTheme.color,
        size: 20.sp,
      ),
    );
  }
}
