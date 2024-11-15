import 'package:get/get.dart';
import 'package:synergee/app/screens/register.dart';
import '../bindings/login_binding.dart';
import '../bindings/onboarding_binding.dart';
import '../bindings/register_binding.dart';
import '../screens/login_screen.dart';
import '../screens/onboarding_screen.dart';

class AppRoutes {
  static const String ONBOARDING = '/onboarding';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register'; // Register route constant

  static List<GetPage> routes = [
    GetPage(
      name: ONBOARDING,
      page: () => OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: REGISTER,
      page: () => RegisterScreen(),
      binding: RegisterBinding(), // Add Register screen route with binding
    ),
  ];
}
