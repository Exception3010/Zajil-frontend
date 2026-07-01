// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'ZAJIL';

  @override
  String get appTitle => 'Zajil';

  @override
  String get language => 'English';

  @override
  String get signInWithGoogle => 'Sign in with Google';

  @override
  String get privacyPolicyPrefix => 'By continuing, you agree to our ';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get ppSection1Title => 'Information We Collect';

  @override
  String get ppSection1Content =>
      'We collect information you provide directly to us when you use Zajil. This includes your email address and profile information provided through Google Sign-In.';

  @override
  String get ppSection2Title => 'How We Use Your Information';

  @override
  String get ppSection2Content =>
      'We use the information we collect to provide, maintain, and improve our services, and to develop new ones. We also use it to protect Zajil and our users.';

  @override
  String get ppSection3Title => 'Information Sharing';

  @override
  String get ppSection3Content =>
      'We do not share your personal information with companies, organizations, or individuals outside of Zajil except in the following cases: with your consent, for external processing, or for legal reasons.';

  @override
  String get ppSection4Title => 'Data Security';

  @override
  String get ppSection4Content =>
      'We work hard to protect Zajil and our users from unauthorized access to or unauthorized alteration, disclosure, or destruction of information we hold.';

  @override
  String get ppSection5Title => 'Your Choices';

  @override
  String get ppSection5Content =>
      'You may opt out of certain data collection or use by contacting us or adjusting your settings within the app.';

  @override
  String get ppLastUpdated => 'Last Updated: October 2023';

  @override
  String get chooseYourHandle => 'Choose your handle';

  @override
  String get uniqueIdOnZajil => 'Your unique ID on ZAJIL.';

  @override
  String get username => 'username';

  @override
  String get available => 'Available';

  @override
  String charsCount(int count) {
    return '$count/20 chars';
  }

  @override
  String get handleDescription =>
      'Your handle is how others find your visual wisdom. Like a digital signature, it marks your presence in the gallery.';

  @override
  String get claimUsername => 'Claim Username';

  @override
  String get communityGuidelinesAgreement =>
      'By claiming, you agree to our Community Guidelines';

  @override
  String get homeReceivedWisdom => 'Received Wisdom';

  @override
  String get homeCuratedReflections => 'Today\'s curated reflections';

  @override
  String get homeEmptyTitle => 'No quotes yet';

  @override
  String get homeEmptySubtitle => 'Quotes your friends send will appear here.';

  @override
  String get via => 'via';

  @override
  String get navHome => 'Home';

  @override
  String get navFriends => 'Friends';

  @override
  String get navProfile => 'Profile';

  @override
  String get signOut => 'Sign out';

  @override
  String get quoteSetAsWidget => 'Set as your home-screen widget';

  @override
  String comingSoon(String feature) {
    return '$feature coming soon';
  }
}
