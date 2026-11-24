import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'prefs.dart';

/// App language. Arabic is the default because the first market is Egypt.
class LocaleController extends Notifier<Locale> {
  static const _key = 'locale';

  @override
  Locale build() {
    final saved = ref.read(sharedPrefsProvider).getString(_key);
    return Locale(saved ?? 'ar');
  }

  void setLocale(Locale locale) {
    state = locale;
    ref.read(sharedPrefsProvider).setString(_key, locale.languageCode);
  }

  void toggle() => setLocale(Locale(state.languageCode == 'ar' ? 'en' : 'ar'));
}

final localeProvider =
    NotifierProvider<LocaleController, Locale>(LocaleController.new);
