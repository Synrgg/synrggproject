import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synergee/app/controllers/login_controller.dart';
import 'package:synergee/app/routes/app_routes.dart';
import 'package:synergee/app/controllers/auth_controller.dart';
import 'package:synergee/app/themes/theme.dart';
import 'app/bindings/Community_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kunbvhwbkapgckfcgzyj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt1bmJ2aHdia2FwZ2NrZmNnenlqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYxNjYwOTQsImV4cCI6MjA1MTc0MjA5NH0.3UVP6H9VpcSDC9grCV1xIfGRIYwUk-IpC4zf0Oe-TFI',
  );

  Get.put(AuthController(), permanent: true);
  Get.put(LoginController(), permanent: true);

  final communityBinding = CommunityScreenBinding();
  communityBinding.dependencies();

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
