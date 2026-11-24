import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teacher_app/app.dart';
import 'package:teacher_app/core/settings/prefs.dart';

Future<void> pumpApp(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(ProviderScope(
    overrides: [sharedPrefsProvider.overrideWithValue(prefs)],
    child: const TeacherDeskApp(),
  ));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('starts in Arabic, right-to-left', (tester) async {
    await pumpApp(tester);
    expect(find.text('مكتب المدرس'), findsOneWidget);
    final dir = Directionality.of(tester.element(find.text('مكتب المدرس')));
    expect(dir, TextDirection.rtl);
  });

  testWidgets('switches to English', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();
    expect(find.text('Teacher Desk'), findsOneWidget);
  });

  testWidgets('teacher role opens teacher dashboard', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.byKey(const Key('continue')));
    await tester.pumpAndSettle();
    expect(find.text('مجموعة جديدة'), findsOneWidget); // FAB
  });

  testWidgets('parent role opens parent dashboard', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('ولي أمر'));
    await tester.tap(find.byKey(const Key('continue')));
    await tester.pumpAndSettle();
    expect(find.text('أولادي'), findsWidgets);
  });
}
