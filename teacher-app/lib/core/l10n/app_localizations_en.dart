// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Teacher Desk';

  @override
  String get tagline =>
      'Every app out there is built for schools. We\'re built for the teacher.';

  @override
  String get chooseLanguage => 'Language';

  @override
  String get whoAreYou => 'Who are you?';

  @override
  String get roleTeacher => 'Teacher';

  @override
  String get roleTeacherDesc => 'Manage your students, groups, exams and fees';

  @override
  String get roleStudent => 'Student';

  @override
  String get roleStudentDesc => 'Solve homework and track your level';

  @override
  String get roleParent => 'Parent';

  @override
  String get roleParentDesc => 'Follow your child\'s attendance and grades';

  @override
  String get continueBtn => 'Continue';

  @override
  String get logout => 'Log out';

  @override
  String hello(String name) {
    return 'Hello, $name';
  }

  @override
  String get statStudents => 'Students';

  @override
  String get statGroups => 'Groups';

  @override
  String get statPending => 'To grade';

  @override
  String get statAverage => 'Average';

  @override
  String get myGroups => 'My groups';

  @override
  String studentsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count students',
      one: '1 student',
      zero: 'No students',
    );
    return '$_temp0';
  }

  @override
  String get newGroup => 'New group';

  @override
  String get inviteCode => 'Invite code';

  @override
  String get comingSoon => 'Coming soon in the next step';

  @override
  String get pendingWork => 'Due soon';

  @override
  String dueIn(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: 'Due in $days days',
      one: 'Due tomorrow',
      zero: 'Due today',
    );
    return '$_temp0';
  }

  @override
  String get myLevel => 'My level';

  @override
  String get levelHint => 'Based on your last 5 exams';

  @override
  String get startBtn => 'Start';

  @override
  String get myChildren => 'My children';

  @override
  String get attendanceRate => 'Attendance';

  @override
  String get lastExam => 'Last exam';

  @override
  String get missingHomework => 'Missing homework';

  @override
  String get recentActivity => 'Recent activity';

  @override
  String get demoNotice =>
      'Demo data: the real backend is connected in the next step';
}
