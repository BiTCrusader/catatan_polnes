import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/tema_notifier.dart';
import '../theme/tokens.dart';

class LayarPengaturan extends ConsumerWidget {
  const LayarPengaturan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modeSaatIni = ref.watch(temaNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          const Text(
            'Tampilan Aplikasi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppSpacing.sm),
          Card(
            child: RadioGroup<ThemeMode>(
              groupValue: modeSaatIni,
              onChanged: (val) {
                if (val != null) {
                  ref.read(temaNotifierProvider.notifier).ubahTema(val);
                }
              },
              child: const Column(
                children: [
                  RadioListTile<ThemeMode>(
                    title: Text('Ikuti Sistem HP'),
                    subtitle: Text('Menyesuaikan tema otomatis dari perangkat'),
                    value: ThemeMode.system,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text('Mode Terang'),
                    value: ThemeMode.light,
                  ),
                  RadioListTile<ThemeMode>(
                    title: Text('Mode Gelap'),
                    value: ThemeMode.dark,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}