import 'package:material_ui/material_ui.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/widgets/common.dart';

const _pending = [
  (title: 'واجب الباب التالت: الكيمياء العضوية', teacher: 'أ. محمد', days: 0),
  (title: 'امتحان قصير: المتجهات', teacher: 'أ. سارة (فيزياء)', days: 2),
  (title: 'Unit 4 Vocabulary', teacher: 'Mr. Adam', days: 5),
];

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.hello('يوسف')),
        actions: const [LanguageButton(), LogoutButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const DemoBanner(),
          const SizedBox(height: 16),
          Card(
            color: t.colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Row(children: [
                SizedBox(
                  width: 72,
                  height: 72,
                  child: Stack(alignment: Alignment.center, children: [
                    CircularProgressIndicator(value: .82, strokeWidth: 7, backgroundColor: t.colorScheme.surface),
                    Text('82%', style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  ]),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(l.myLevel, style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
                    Text(l.levelHint, style: t.textTheme.bodySmall),
                  ]),
                ),
              ]),
            ),
          ),
          SectionTitle(l.pendingWork),
          for (final p in _pending) ...[
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: Icon(Icons.assignment_outlined, color: p.days == 0 ? t.colorScheme.error : t.colorScheme.primary),
                title: Text(p.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('${p.teacher} · ${l.dueIn(p.days)}'),
                trailing: FilledButton.tonal(
                  // Theme makes filled buttons full-width; keep this one compact.
                  style: FilledButton.styleFrom(minimumSize: const Size(64, 40)),
                  onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.comingSoon))),
                  child: Text(l.startBtn),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
