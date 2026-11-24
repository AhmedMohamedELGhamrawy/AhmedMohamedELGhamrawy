import 'package:material_ui/material_ui.dart';

import '../../core/l10n/app_localizations.dart';
import '../../core/widgets/common.dart';

// Demo data until the Supabase backend lands (roadmap step 4).
const _groups = [
  (name: 'ثالثة ثانوي: السبت ٤م', students: 42, code: 'CHM-4821'),
  (name: 'ثالثة ثانوي: الاتنين ٦م', students: 38, code: 'CHM-1937'),
  (name: 'تانية ثانوي: أونلاين', students: 25, code: 'CHM-5560'),
];

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final total = _groups.fold<int>(0, (s, g) => s + g.students);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.hello('أ. محمد')),
        actions: const [LanguageButton(), LogoutButton()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l.comingSoon))),
        icon: const Icon(Icons.group_add),
        label: Text(l.newGroup),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
        children: [
          const DemoBanner(),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.45,
            children: [
              StatCard(icon: Icons.people_alt_outlined, label: l.statStudents, value: '$total'),
              StatCard(icon: Icons.groups_2_outlined, label: l.statGroups, value: '${_groups.length}'),
              StatCard(icon: Icons.rate_review_outlined, label: l.statPending, value: '17'),
              StatCard(icon: Icons.insights_outlined, label: l.statAverage, value: '78%'),
            ],
          ),
          SectionTitle(l.myGroups),
          for (final g in _groups) ...[
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                leading: const CircleAvatar(child: Icon(Icons.groups)),
                title: Text(g.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('${l.studentsCount(g.students)} · ${l.inviteCode}: ${g.code}'),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}
