// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مكتب المدرس';

  @override
  String get tagline => 'كل التطبيقات معمولة للمدرسة، وإحنا معمولين للمدرس.';

  @override
  String get chooseLanguage => 'اللغة';

  @override
  String get whoAreYou => 'إنت مين؟';

  @override
  String get roleTeacher => 'مدرس';

  @override
  String get roleTeacherDesc => 'إدارة طلابك ومجموعاتك وامتحاناتك ومصاريفك';

  @override
  String get roleStudent => 'طالب';

  @override
  String get roleStudentDesc => 'حل واجباتك وتابع مستواك';

  @override
  String get roleParent => 'ولي أمر';

  @override
  String get roleParentDesc => 'تابع حضور ودرجات ابنك';

  @override
  String get continueBtn => 'متابعة';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String hello(String name) {
    return 'أهلاً، $name';
  }

  @override
  String get statStudents => 'الطلاب';

  @override
  String get statGroups => 'المجموعات';

  @override
  String get statPending => 'محتاج تصحيح';

  @override
  String get statAverage => 'المتوسط';

  @override
  String get myGroups => 'مجموعاتي';

  @override
  String studentsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count طالب',
      many: '$count طالبًا',
      few: '$count طلاب',
      two: 'طالبان',
      one: 'طالب واحد',
      zero: 'لا يوجد طلاب',
    );
    return '$_temp0';
  }

  @override
  String get newGroup => 'مجموعة جديدة';

  @override
  String get inviteCode => 'كود الدعوة';

  @override
  String get comingSoon => 'جاية في الخطوة الجاية';

  @override
  String get pendingWork => 'مطلوب قريب';

  @override
  String dueIn(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'باقي $days يوم',
      many: 'باقي $days يومًا',
      few: 'باقي $days أيام',
      two: 'باقي يومين',
      one: 'آخر ميعاد بكرة',
      zero: 'آخر ميعاد النهارده',
    );
    return '$_temp0';
  }

  @override
  String get myLevel => 'مستواي';

  @override
  String get levelHint => 'حسب آخر 5 امتحانات';

  @override
  String get startBtn => 'ابدأ';

  @override
  String get myChildren => 'أولادي';

  @override
  String get attendanceRate => 'الحضور';

  @override
  String get lastExam => 'آخر امتحان';

  @override
  String get missingHomework => 'واجبات ناقصة';

  @override
  String get recentActivity => 'آخر الأخبار';

  @override
  String get demoNotice =>
      'بيانات تجريبية: السيرفر الحقيقي هيتوصل في الخطوة الجاية';
}
