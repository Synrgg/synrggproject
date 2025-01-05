import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synergee/app/controllers/login_controller.dart';
import 'package:synergee/app/routes/app_routes.dart';
import 'package:synergee/app/controllers/auth_controller.dart';
import 'package:synergee/app/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Show the status bar and navigation bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Set the status bar overlay style
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent for gradient
    statusBarIconBrightness: Brightness.light, // Icons will be white
    systemNavigationBarColor: Colors.black,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://alhsisagxymlexjkxvti.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFsaHNpc2FneHltbGV4amt4dnRpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU5MDg3OTQsImV4cCI6MjA1MTQ4NDc5NH0.d18uDYgTnxm68G6o8kBUudUzi_blr_H1iYJZEFDwPW0',
  );

  // Initialize Controllers
  Get.put(AuthController(), permanent: true);
  Get.put(LoginController());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();

    // Initialize animation
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticInOut,
      ),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Start initialization
    _initialization = _initializeApp();
    _animationController.repeat(reverse: true); // Loop animation
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(
                  extendBodyBehindAppBar: true,
                  body: Stack(
                    children: [
                      // Neon gaming background
                      const AnimatedNeonBackground(),
                      // Centered loader animation
                      Center(
                        child: SingleChildScrollView(
                          child: AnimatedBuilder(
                            animation: _animationController,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: _scaleAnimation.value,
                                child: Transform.rotate(
                                  angle: _rotationAnimation.value,
                                  child: Opacity(
                                    opacity: _fadeAnimation.value,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        // Gaming logo
                                        Container(
                                          width: 120.sp,
                                          height: 120.sp,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: const RadialGradient(
                                              colors: [
                                                Colors.purpleAccent,
                                                Colors.blueAccent,
                                                Colors.black,
                                              ],
                                              radius: 0.85,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.purpleAccent
                                                    .withOpacity(0.5),
                                                blurRadius: 30,
                                                spreadRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.gamepad_rounded,
                                              size: 60.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        // Loading text
                                        Text(
                                          "Initializing the Arena...",
                                          style: TextStyle(
                                            fontFamily: 'Orbitron',
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: Colors.purpleAccent,
                                                blurRadius: 10,
                                                offset: Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasError) {
              return const MaterialApp(
                home: Scaffold(
                  body: Center(
                    child: Text(
                      "Error initializing app. Please restart.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              );
            }

            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Synergee',
              theme: AppTheme.lightTheme(),
              darkTheme: AppTheme.darkTheme(),
              themeMode: _getThemeMode(),
              initialRoute: _getInitialRoute(),
              getPages: AppRoutes.routes,
            );
          },
        );
      },
    );
  }

  /// Initialize any app-specific dependencies or services
  Future<void> _initializeApp() async {
    try {
      final authController = Get.find<AuthController>();
      await authController.initializeAuthState();
    } catch (e) {
      debugPrint("Initialization error: $e");
      rethrow;
    }
  }

  /// Get the theme mode (system, light, or dark)
  ThemeMode _getThemeMode() {
    return ThemeMode.system;
  }

  /// Get the initial route
  String _getInitialRoute() {
    final authController = Get.find<AuthController>();
    if (authController.isSignedIn.value) {
      return AppRoutes.HOME;
    }
    return AppRoutes.ONBOARDING;
  }
}

/// Neon gradient animated background
class AnimatedNeonBackground extends StatelessWidget {
  const AnimatedNeonBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.blueGrey,
            Colors.purple,
            Colors.black,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
