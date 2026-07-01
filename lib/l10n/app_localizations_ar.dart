// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'زَاجِــــــل';

  @override
  String get appTitle => 'زاجل';

  @override
  String get language => 'العربية';

  @override
  String get signInWithGoogle => 'تسجيل الدخول باستخدام جوجل';

  @override
  String get privacyPolicyPrefix => 'بالاستمرار، أنت توافق على ';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get ppSection1Title => 'المعلومات التي نجمعها';

  @override
  String get ppSection1Content =>
      'نحن نجمع المعلومات التي تقدمها لنا مباشرة عند استخدام زاجل. يتضمن ذلك عنوان بريدك الإلكتروني ومعلومات الملف الشخصي المقدمة من خلال تسجيل الدخول باستخدام جوجل.';

  @override
  String get ppSection2Title => 'كيفية استخدامنا لمعلوماتك';

  @override
  String get ppSection2Content =>
      'نستخدم المعلومات التي نجمعها لتوفير خدماتنا وصيانتها وتحسينها، ولتطوير خدمات جديدة. نستخدمها أيضاً لحماية زاجل ومستخدمينا.';

  @override
  String get ppSection3Title => 'مشاركة المعلومات';

  @override
  String get ppSection3Content =>
      'نحن لا نشارك معلوماتك الشخصية مع الشركات أو المؤسسات أو الأفراد خارج زاجل إلا في الحالات التالية: بموافقتك، أو للمعالجة الخارجية، أو لأسباب قانونية.';

  @override
  String get ppSection4Title => 'أمن البيانات';

  @override
  String get ppSection4Content =>
      'نحن نعمل بجد لحماية زاجل ومستخدمينا من الوصول غير المصرح به أو التعديل أو الكشف أو التدمير غير المصرح به للمعلومات التي نحتفظ بها.';

  @override
  String get ppSection5Title => 'خياراتك';

  @override
  String get ppSection5Content =>
      'يمكنك إلغاء الاشتراك في بعض عمليات جمع البيانات أو استخدامها من خلال الاتصال بنا أو تعديل إعداداتك داخل التطبيق.';

  @override
  String get ppLastUpdated => 'آخر تحديث: أكتوبر ٢٠٢٣';

  @override
  String get chooseYourHandle => 'اختر معرفك';

  @override
  String get uniqueIdOnZajil => 'معرفك الفريد على زاجل.';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get available => 'متاح';

  @override
  String charsCount(int count) {
    return '$count/20 حرف';
  }

  @override
  String get handleDescription =>
      'معرفك هو الطريقة التي يجد بها الآخرون حكمتك البصرية. مثل التوقيع الرقمي، فهو يميز حضورك في المعرض.';

  @override
  String get claimUsername => 'حجز اسم المستخدم';

  @override
  String get communityGuidelinesAgreement =>
      'بحجزك للاسم، أنت توافق على إرشادات المجتمع الخاصة بنا';

  @override
  String get homeReceivedWisdom => 'حِكَمٌ وصلتك';

  @override
  String get homeCuratedReflections => 'تأملات اليوم المختارة';

  @override
  String get homeEmptyTitle => 'لا توجد اقتباسات بعد';

  @override
  String get homeEmptySubtitle => 'ستظهر هنا الاقتباسات التي يرسلها أصدقاؤك.';

  @override
  String get via => 'عبر';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navFriends => 'الأصدقاء';

  @override
  String get navProfile => 'الملف الشخصي';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get quoteSetAsWidget => 'تم التعيين على شاشتك الرئيسية';

  @override
  String comingSoon(String feature) {
    return '$feature قريباً';
  }
}
