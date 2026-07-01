import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zajil/l10n/app_localizations.dart';
import 'package:zajil/login_screen.dart';
import 'package:zajil/main.dart';
import 'package:zajil/models/feed_quote.dart';
import 'package:zajil/services/widget_service.dart';
import 'package:zajil/widgets/quote_feed_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Design tokens (home.html tailwind config).
  static const _primary = Color(0xFF0D6683);
  static const _primaryContainer = Color(0xFF89CFF0);
  static const _secondaryContainer = Color(0xFFC1E5FC);
  static const _onSecondaryContainer = Color(0xFF44677B);
  static const _surfaceBright = Color(0xFFF7FAFC);
  static const _surfaceContainerLow = Color(0xFFF1F4F6);
  static const _surfaceContainerLowest = Color(0xFFFFFFFF);
  static const _onSurface = Color(0xFF181C1E);
  static const _onSurfaceVariant = Color(0xFF40484D);

  // Placeholder feed — hardcoded until the receive-a-quote flow exists.
  static const List<FeedQuote> _quotes = [
    FeedQuote(
      text:
          '"The soul always knows what to do to heal itself. The challenge is to silence the mind."',
      author: 'Caroline Myss',
      viaHandle: 'serene_scribe',
      timeAgo: '2h ago',
      italic: true,
    ),
    FeedQuote(
      text:
          'True silence is the rest of the mind, and is to the spirit what sleep is to the body, nourishment and refreshment.',
      author: 'William Penn',
      viaHandle: 'william_p',
      timeAgo: '5h ago',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAXRVK5Ne3GQbnwVP0KZRNOvE1k76a7gr7zXl3Ce5fvOWKNq9xzfmGiYj4M57uMNnVbIK4rig3rxh8S_SVGeGMAsmrNIu7tPkbyVgRwIG2uxAJGNrT7lmwGa6l7cQ0_GyPPPXEqIR4gMaHElUZ3G2I4jRXuxqCHAioIkDfS49d2coVMdjqfACCs6gl3CkZJvQxxWole2zcgAstKl_0YuJQDQo-zm-0lpHysKNMpaT2vISOGXRtjak3DCohhun96KTAs63VEVFcwIUvA',
    ),
    FeedQuote(
      text: '"Simplicity is the ultimate sophistication."',
      author: 'Leonardo da Vinci',
      viaHandle: 'da_vinci_codes',
      timeAgo: '8h ago',
    ),
    FeedQuote(
      text:
          '"Your vision will become clear only when you can look into your own heart. Who looks outside, dreams; who looks inside, awakes."',
      author: 'Carl Jung',
      viaHandle: 'jungian_depths',
      timeAgo: '1d ago',
      italic: true,
    ),
    FeedQuote(
      text:
          'In the midst of movement and chaos, keep stillness inside of you.',
      author: 'Deepak Chopra',
      viaHandle: 'calm_navigator',
      timeAgo: '1d ago',
    ),
    FeedQuote(
      text: '"Nature does not hurry, yet everything is accomplished."',
      author: 'Lao Tzu',
      viaHandle: 'ancient_echoes',
      timeAgo: '2d ago',
    ),
  ];

  /// Interim behavior: tapping a received quote sets it as your own
  /// home-screen widget. Will be replaced by a quote-detail / actions sheet.
  Future<void> _setAsWidget(BuildContext context, FeedQuote quote) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);
    await WidgetService.updateQuote(quote: quote.text, author: quote.author);
    messenger.showSnackBar(
      SnackBar(
        content: Text(l10n.quoteSetAsWidget),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _comingSoon(BuildContext context, String feature) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.comingSoon(feature)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleLanguage(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    MyApp.of(context)?.setLocale(Locale(isArabic ? 'en' : 'ar'));
  }

  // Sign-out lives in Profile eventually; surfaced from the avatar for now.
  Future<void> _signOut(BuildContext context) async {
    final navigator = Navigator.of(context);
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  void _openProfileSheet(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: _surfaceContainerLowest,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.logout, color: _primary),
              title: Text(l10n.signOut),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final topInset = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: _surfaceContainerLow,
      body: Stack(
        children: [
          // Scrolling feed.
          Positioned.fill(
            child: ListView.separated(
              padding: EdgeInsets.only(
                top: topInset + 80,
                bottom: bottomInset + 140,
                left: 24,
                right: 24,
              ),
              itemCount: _quotes.length + 1,
              separatorBuilder: (_, _) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                if (index == 0) return _sectionHeader(l10n);
                final quote = _quotes[index - 1];
                return QuoteFeedCard(
                  quote: quote,
                  onTap: () => _setAsWidget(context, quote),
                );
              },
            ),
          ),

          // Glass top app bar.
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _glass(
              color: _surfaceBright.withValues(alpha: 0.8),
              child: Padding(
                padding: EdgeInsets.only(
                  top: topInset + 12,
                  bottom: 12,
                  left: 24,
                  right: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _avatar(context),
                    Text(
                      l10n.appName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                        color: _primary,
                        fontFamily: 'Inter',
                      ),
                    ),
                    IconButton(
                      onPressed: () => _toggleLanguage(context),
                      icon: const Icon(Icons.language,
                          color: _onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Floating "create" button. `end` resolves to the right in LTR and
          // the left in RTL (Arabic), so it follows the reading direction.
          PositionedDirectional(
            end: 24,
            bottom: bottomInset + 96,
            child: _fab(context),
          ),

          // Glass bottom navigation.
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _bottomNav(context, l10n, bottomInset),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.homeReceivedWisdom.toUpperCase(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
            color: _onSurfaceVariant,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.homeCuratedReflections,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
            color: _onSurface,
            fontFamily: 'Inter',
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _avatar(BuildContext context) {
    final photoUrl = FirebaseAuth.instance.currentUser?.photoURL;
    return GestureDetector(
      onTap: () => _openProfileSheet(context),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: _secondaryContainer,
        ),
        clipBehavior: Clip.antiAlias,
        child: photoUrl != null
            ? Image.network(
                photoUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    const Icon(Icons.person, color: _primary, size: 22),
              )
            : const Icon(Icons.person, color: _primary, size: 22),
      ),
    );
  }

  Widget _fab(BuildContext context) {
    return GestureDetector(
      onTap: () => _comingSoon(context, 'Compose'),
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [_primary, _primaryContainer],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: _onSurface.withValues(alpha: 0.06),
              blurRadius: 24,
            ),
          ],
        ),
        child: const Icon(Icons.add_circle_outline,
            color: Colors.white, size: 30),
      ),
    );
  }

  Widget _bottomNav(
      BuildContext context, AppLocalizations l10n, double bottomInset) {
    return _glass(
      color: _surfaceContainerLowest.withValues(alpha: 0.8),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Padding(
        padding: EdgeInsets.only(
          top: 12,
          bottom: bottomInset + 12,
          left: 16,
          right: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, l10n.navHome, active: true, onTap: () {}),
            _navItem(Icons.group, l10n.navFriends,
                onTap: () => _comingSoon(context, l10n.navFriends)),
            _navItem(Icons.person, l10n.navProfile,
                onTap: () => _comingSoon(context, l10n.navProfile)),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label,
      {bool active = false, required VoidCallback onTap}) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon,
            color: active ? _onSecondaryContainer : _onSurfaceVariant,
            size: 24),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: active ? _onSecondaryContainer : _onSurfaceVariant,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: active
          ? Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: _secondaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: content,
            )
          : Opacity(opacity: 0.7, child: content),
    );
  }

  // Glassmorphic container: backdrop blur behind a translucent fill.
  Widget _glass({
    required Color color,
    required Widget child,
    BorderRadius? borderRadius,
  }) {
    final clip = ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(color: color, child: child),
      ),
    );
    return clip;
  }
}
