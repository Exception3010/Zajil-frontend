import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zajil/services/user_service.dart';
import 'login_screen.dart';
import 'set_username_screen.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _dotController;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _checkNavigation();
  }

  Future<void> _checkNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _navigateTo(const LoginScreen());
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final localUsername = prefs.getString('username');

    if (localUsername != null) {
      _navigateTo(const HomeScreen());
      return;
    }

    try {
      final userProfile = await _userService.getUserProfile(user.uid);

      if (userProfile != null) {
        await prefs.setString('username', userProfile.username);
        _navigateTo(const HomeScreen());
      } else {
        _navigateTo(const SetUsernameScreen());
      }
    } catch (e) {
      // If server is unavailable and we have no local data, 
      // we navigate to Login so user can try again.
      _navigateTo(const LoginScreen());
    }
  }

  void _navigateTo(Widget screen) {
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => screen),
      );
    }
  }

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0D6683);
    const secondaryColor = Color(0xFF406376);
    const surfaceBright = Color(0xFFF7FAFC);
    const outlineVariant = Color(0xFFBFC8CD);

    return Scaffold(
      backgroundColor: surfaceBright,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 128,
                  height: 128,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 128),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: IntrinsicHeight(
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                'ZAJIL',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 8,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(
                            color: outlineVariant,
                            thickness: 1,
                            indent: 4,
                            endIndent: 4,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'زاجـــــــــل',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w300,
                                  color: primaryColor,
                                ),
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 64,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedBuilder(
                  animation: _dotController,
                  builder: (context, child) {
                    double delay = index * 0.2;
                    double value = (_dotController.value - delay).clamp(0.0, 1.0);
                    double opacity = 0.3 + (0.7 * (1.0 - (value - 0.5).abs() * 2));
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withValues(alpha: opacity.clamp(0.3, 1.0)),
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
