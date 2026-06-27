import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zajil/home_screen.dart';
import 'package:zajil/l10n/app_localizations.dart';
import 'package:zajil/models/user_model.dart';
import 'package:zajil/services/user_service.dart';

class SetUsernameScreen extends StatefulWidget {
  const SetUsernameScreen({super.key});

  @override
  State<SetUsernameScreen> createState() => _SetUsernameScreenState();
}

class _SetUsernameScreenState extends State<SetUsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final UserService _userService = UserService();
  bool _isLoading = false;
  bool _isAvailable = true;

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _claimUsername() async {
    final username = _usernameController.text.trim();
    if (username.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userModel = UserModel(
          uid: user.uid,
          username: username,
          email: user.email ?? '',
          displayName: user.displayName,
          photoUrl: user.photoURL,
          appLanguage: Localizations.localeOf(context).languageCode,
          appTheme: 'system',
          createdAt: DateTime.now(),
          friendsUids: [],
        );

        await _userService.saveUserProfile(userModel);

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving username: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    const primaryColor = Color(0xFF0D6683);
    const primaryContainer = Color(0xFF89CFF0);
    const surfaceBright = Color(0xFFF7FAFC);
    const onSurface = Color(0xFF181C1E);
    const onSurfaceVariant = Color(0xFF40484D);
    const surfaceContainerLow = Color(0xFFF1F4F6);
    const surfaceContainerLowest = Color(0xFFFFFFFF);
    const outlineVariant = Color(0xFFBFC8CD);
    const outline = Color(0xFF70787D);

    return Scaffold(
      backgroundColor: surfaceBright,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 64,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image, size: 64, color: primaryColor),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      l10n.chooseYourHandle,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: onSurface,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.uniqueIdOnZajil,
                      style: const TextStyle(
                        fontSize: 14,
                        color: onSurfaceVariant,
                        letterSpacing: 0.5,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              Container(
                decoration: BoxDecoration(
                  color: surfaceContainerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Row(
                  children: [
                    const Text(
                      '@',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _usernameController,
                        enabled: !_isLoading,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: onSurface,
                        ),
                        decoration: InputDecoration(
                          hintText: l10n.username,
                          hintStyle: const TextStyle(color: outlineVariant),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onChanged: (value) async {
                          if (value.length >= 3) {
                             bool available = await _userService.isUsernameAvailable(value);
                             setState(() {
                               _isAvailable = available;
                             });
                          }
                        },
                      ),
                    ),
                    if (_usernameController.text.isNotEmpty && _isAvailable && !_isLoading)
                      const Icon(Icons.check_circle, color: primaryColor, size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (_usernameController.text.isNotEmpty && _isAvailable) ? l10n.available.toUpperCase() : '',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      l10n.charsCount(_usernameController.text.length).toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        letterSpacing: 1,
                        color: onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryContainer.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.history_edu, color: primaryColor, size: 20),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        l10n.handleDescription,
                        style: const TextStyle(
                          fontSize: 14,
                          color: onSurfaceVariant,
                          height: 1.5,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      gradient: const LinearGradient(
                        colors: [primaryColor, primaryContainer],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: (_isLoading || _usernameController.text.isEmpty || !_isAvailable) ? null : _claimUsername,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: _isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            l10n.claimUsername.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 2,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.communityGuidelinesAgreement.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: outline,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
