import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zajil/l10n/app_localizations.dart';
import 'package:zajil/privacy_policy_sheet.dart';
import 'package:zajil/home_screen.dart';
import 'package:zajil/set_username_screen.dart';
import 'package:zajil/services/user_service.dart';
import 'main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  final UserService _userService = UserService();

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      
      if (googleUser == null) {
        if (mounted) setState(() => _isLoading = false);
        return; 
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null && mounted) {
        await _fetchUserProfileWithRetry(user);
      }
      
    } catch (e) {
      _showError('Sign-in Error: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchUserProfileWithRetry(User user, {int retries = 2}) async {
    try {
      final userProfile = await _userService.getUserProfile(user.uid);

      if (!mounted) return;

      if (userProfile != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', userProfile.username);

        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SetUsernameScreen()),
        );
      }
    } catch (e) {
      if (retries > 0) {
        await Future.delayed(const Duration(seconds: 2));
        return _fetchUserProfileWithRetry(user, retries: retries - 1);
      }
      
      String errorMessage = 'Firestore Error: $e';
      if (e is FirebaseException && e.code == 'unavailable') {
        errorMessage = 'Firestore is currently unreachable. Please ensure you have created the database in the Firebase Console and that your emulator has a stable internet connection.';
      }
      _showError(errorMessage);
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 6),
        ),
      );
    }
  }

  void _showPrivacyPolicy() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PrivacyPolicySheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    const primaryColor = Color(0xFF0D6683);
    const primaryContainer = Color(0xFF89CFF0);
    const secondaryContainer = Color(0xFFC1E5FC);
    const surfaceBright = Color(0xFFF7FAFC);
    const onSurface = Color(0xFF181C1E);
    const onSurfaceVariant = Color(0xFF40484D);

    return Scaffold(
      backgroundColor: surfaceBright,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryContainer.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: secondaryContainer.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    surfaceBright,
                    surfaceBright.withValues(alpha: 0),
                  ],
                ),
              ),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.appName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: primaryColor,
                        fontFamily: 'Inter',
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        final newLocale = isArabic ? const Locale('en') : const Locale('ar');
                        MyApp.of(context)?.setLocale(newLocale);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.language, size: 18, color: primaryColor),
                          const SizedBox(width: 4),
                          Text(
                            l10n.language,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 96,
                    height: 96,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image, size: 96),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.appTitle,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: primaryContainer,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: 48),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      gradient: const LinearGradient(
                        colors: [primaryColor, primaryContainer],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    padding: const EdgeInsets.all(1.5),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _signInWithGoogle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: onSurface,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: _isLoading 
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: SvgPicture.asset(
                                  'assets/images/google_logo.svg',
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.contain,
                                  placeholderBuilder: (context) =>
                                      const Icon(Icons.login, size: 20),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                l10n.signInWithGoogle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text.rich(
                    TextSpan(
                      text: l10n.privacyPolicyPrefix,
                      style: const TextStyle(
                        color: onSurfaceVariant,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                      children: [
                        TextSpan(
                          text: l10n.privacyPolicy,
                          style: const TextStyle(
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = _showPrivacyPolicy,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
