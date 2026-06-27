import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'ZAJIL'**
  String get appName;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Zajil'**
  String get appTitle;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @signInWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signInWithGoogle;

  /// No description provided for @privacyPolicyPrefix.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our '**
  String get privacyPolicyPrefix;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @ppSection1Title.
  ///
  /// In en, this message translates to:
  /// **'Information We Collect'**
  String get ppSection1Title;

  /// No description provided for @ppSection1Content.
  ///
  /// In en, this message translates to:
  /// **'We collect information you provide directly to us when you use Zajil. This includes your email address and profile information provided through Google Sign-In.'**
  String get ppSection1Content;

  /// No description provided for @ppSection2Title.
  ///
  /// In en, this message translates to:
  /// **'How We Use Your Information'**
  String get ppSection2Title;

  /// No description provided for @ppSection2Content.
  ///
  /// In en, this message translates to:
  /// **'We use the information we collect to provide, maintain, and improve our services, and to develop new ones. We also use it to protect Zajil and our users.'**
  String get ppSection2Content;

  /// No description provided for @ppSection3Title.
  ///
  /// In en, this message translates to:
  /// **'Information Sharing'**
  String get ppSection3Title;

  /// No description provided for @ppSection3Content.
  ///
  /// In en, this message translates to:
  /// **'We do not share your personal information with companies, organizations, or individuals outside of Zajil except in the following cases: with your consent, for external processing, or for legal reasons.'**
  String get ppSection3Content;

  /// No description provided for @ppSection4Title.
  ///
  /// In en, this message translates to:
  /// **'Data Security'**
  String get ppSection4Title;

  /// No description provided for @ppSection4Content.
  ///
  /// In en, this message translates to:
  /// **'We work hard to protect Zajil and our users from unauthorized access to or unauthorized alteration, disclosure, or destruction of information we hold.'**
  String get ppSection4Content;

  /// No description provided for @ppSection5Title.
  ///
  /// In en, this message translates to:
  /// **'Your Choices'**
  String get ppSection5Title;

  /// No description provided for @ppSection5Content.
  ///
  /// In en, this message translates to:
  /// **'You may opt out of certain data collection or use by contacting us or adjusting your settings within the app.'**
  String get ppSection5Content;

  /// No description provided for @ppLastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last Updated: October 2023'**
  String get ppLastUpdated;

  /// No description provided for @chooseYourHandle.
  ///
  /// In en, this message translates to:
  /// **'Choose your handle'**
  String get chooseYourHandle;

  /// No description provided for @uniqueIdOnZajil.
  ///
  /// In en, this message translates to:
  /// **'Your unique ID on ZAJIL.'**
  String get uniqueIdOnZajil;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'username'**
  String get username;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @charsCount.
  ///
  /// In en, this message translates to:
  /// **'{count}/20 chars'**
  String charsCount(int count);

  /// No description provided for @handleDescription.
  ///
  /// In en, this message translates to:
  /// **'Your handle is how others find your visual wisdom. Like a digital signature, it marks your presence in the gallery.'**
  String get handleDescription;

  /// No description provided for @claimUsername.
  ///
  /// In en, this message translates to:
  /// **'Claim Username'**
  String get claimUsername;

  /// No description provided for @communityGuidelinesAgreement.
  ///
  /// In en, this message translates to:
  /// **'By claiming, you agree to our Community Guidelines'**
  String get communityGuidelinesAgreement;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
