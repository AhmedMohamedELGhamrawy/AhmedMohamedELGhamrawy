import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/widgets/common.dart';
import 'session.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  AppRole _role = AppRole.teacher;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context);
    final roles = <(AppRole, IconData, String, String)>[
      (AppRole.teacher, Icons.school_outlined, l.roleTeacher, l.roleTeacherDesc),
      (AppRole.student, Icons.menu_book_outlined, l.roleStudent, l.roleStudentDesc),
      (AppRole.parent, Icons.family_restroom_outlined, l.roleParent, l.roleParentDesc),
    ];

    return Scaffold(
      appBar: AppBar(actions: const [LanguageButton(), SizedBox(width: 8)]),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: t.colorScheme.primaryContainer,
              child: Icon(Icons.auto_stories, size: 36, color: t.colorScheme.onPrimaryContainer),
            ),
            const SizedBox(height: 16),
            Text(l.appTitle,
                textAlign: TextAlign.center,
                style: t.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 6),
            Text(l.tagline, textAlign: TextAlign.center, style: t.textTheme.bodyMedium),
            const SizedBox(height: 28),
            Text(l.whoAreYou, style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            for (final (role, icon, title, desc) in roles) ...[
              _RoleTile(
                icon: icon,
                title: title,
                subtitle: desc,
                selected: _role == role,
                onTap: () => setState(() => _role = role),
              ),
              const SizedBox(height: 10),
            ],
            const SizedBox(height: 14),
            FilledButton(
              key: const Key('continue'),
              onPressed: () => ref.read(sessionProvider.notifier).signInAs(_role),
              child: Text(l.continueBtn),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleTile extends StatelessWidget {
  const _RoleTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return Material(
      color: selected ? c.primaryContainer : c.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: selected ? c.primary : Colors.transparent, width: 2),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(children: [
            Icon(icon, size: 30, color: c.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ]),
            ),
            Icon(selected ? Icons.radio_button_checked : Icons.radio_button_off, color: c.primary),
          ]),
        ),
      ),
    );
  }
}
