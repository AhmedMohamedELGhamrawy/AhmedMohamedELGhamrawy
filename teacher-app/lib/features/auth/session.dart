import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/settings/prefs.dart';

enum AppRole { teacher, student, parent }

/// Temporary local session: stores the chosen role only.
/// Replaced by real Supabase auth (phone OTP / email) in step 5.
class SessionController extends Notifier<AppRole?> {
  static const _key = 'role';

  @override
  AppRole? build() {
    final saved = ref.read(sharedPrefsProvider).getString(_key);
    return AppRole.values.where((r) => r.name == saved).firstOrNull;
  }

  void signInAs(AppRole role) {
    state = role;
    ref.read(sharedPrefsProvider).setString(_key, role.name);
  }

  void signOut() {
    state = null;
    ref.read(sharedPrefsProvider).remove(_key);
  }
}

final sessionProvider =
    NotifierProvider<SessionController, AppRole?>(SessionController.new);
