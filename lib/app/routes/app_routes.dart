import 'package:get/get.dart';
import 'package:synergee/app/bindings/Home_binding.dart';
import 'package:synergee/app/screens/home.dart';
import '../bindings/Community_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/onboarding_binding.dart';
import '../bindings/register_binding.dart';
import '../screens/community.dart';
import '../screens/login_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/register.dart';

class AppRoutes {
  static const String ONBOARDING = '/onboarding';
  static const String LOGIN = '/login';
  static const String REGISTER = '/register';
  static const String HOME = '/home';
  static const String COMMUNITY = '/community';

  static List<GetPage> routes = [
    GetPage(
      name: ONBOARDING,
      page: () => OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: LOGIN,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: REGISTER,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: COMMUNITY,
      page: () => CommunityScreen(),
      binding: CommunityScreenBinding(),
    ),
    GetPage(
      name: HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
  ];
}
