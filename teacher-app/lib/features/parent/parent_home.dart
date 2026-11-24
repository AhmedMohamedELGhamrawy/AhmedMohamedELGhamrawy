import 'package:material_ui/material_ui.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/widgets/common.dart';

class ParentHome extends StatelessWidget {
  const ParentHome({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final t = Theme.of(context);
    final activity = [
      (Icons.how_to_reg, 'يوسف وصل السنتر 4:05م · أ. محمد'),
      (Icons.grade_outlined, 'يوسف خد 18/20 في امتحان المتجهات'),
      (Icons.warning_amber_outlined, 'واجب الباب التالت لسه متحلش'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(l.myChildren),
        actions: const [LanguageButton(), LogoutButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          const DemoBanner(),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  CircleAvatar(backgroundColor: t.colorScheme.primaryContainer, child: const Text('ي')),
                  const SizedBox(width: 12),
                  Text('يوسف · ثالثة ثانوي', style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                ]),
                const SizedBox(height: 16),
                Row(children: [
                  Expanded(child: StatCard(icon: Icons.event_available, label: l.attendanceRate, value: '94%')),
                  const SizedBox(width: 10),
                  Expanded(child: StatCard(icon: Icons.grade_outlined, label: l.lastExam, value: '18/20')),
                  const SizedBox(width: 10),
                  Expanded(child: StatCard(icon: Icons.assignment_late_outlined, label: l.missingHomework, value: '1')),
                ]),
              ]),
            ),
          ),
          SectionTitle(l.recentActivity),
          for (final (icon, text) in activity) ...[
            Card(child: ListTile(leading: Icon(icon, color: t.colorScheme.primary), title: Text(text))),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}
