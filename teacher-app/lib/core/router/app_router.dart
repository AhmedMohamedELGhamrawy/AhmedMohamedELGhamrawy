import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/session.dart';
import '../../features/auth/welcome_screen.dart';
import '../../features/parent/parent_home.dart';
import '../../features/student/student_home.dart';
import '../../features/teacher/teacher_home.dart';

String homeFor(AppRole role) => '/${role.name}';

final routerProvider = Provider<GoRouter>((ref) {
  final role = ValueNotifier<AppRole?>(ref.read(sessionProvider));
  ref.listen(sessionProvider, (_, next) => role.value = next);
  ref.onDispose(role.dispose);

  return GoRouter(
    initialLocation: '/welcome',
    refreshListenable: role,
    redirect: (context, state) {
      final current = role.value;
      final loc = state.matchedLocation;
      if (current == null) return loc == '/welcome' ? null : '/welcome';
      // Each role may only see its own area.
      final home = homeFor(current);
      return loc.startsWith(home) ? null : home;
    },
    routes: [
      GoRoute(path: '/welcome', builder: (_, _) => const WelcomeScreen()),
      GoRoute(path: '/teacher', builder: (_, _) => const TeacherHome()),
      GoRoute(path: '/student', builder: (_, _) => const StudentHome()),
      GoRoute(path: '/parent', builder: (_, _) => const ParentHome()),
    ],
  );
});
