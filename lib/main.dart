import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:synergee/app/controllers/login_controller.dart';
import 'package:synergee/app/routes/app_routes.dart';
import 'package:synergee/app/controllers/auth_controller.dart';
import 'package:synergee/app/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController());
  Get.put(LoginController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Synergee',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: _getThemeMode(),
          initialRoute: Get.find<AuthController>().isSignedIn.value
              ? AppRoutes.HOME
              : AppRoutes.ONBOARDING,
          getPages: AppRoutes.routes,
        );
      },
    );
  }

  ThemeMode _getThemeMode() {
    return ThemeMode.system;
  }
}
