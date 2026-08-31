import 'package:flutter/material.dart';
import '../theme/tokens.dart';

class KeadaanKosong extends StatelessWidget {
  const KeadaanKosong({
    super.key,
    required this.ikon,
    required this.judul,
    required this.penjelasan,
    this.labelAksi,
    this.onAksi,
  });

  final IconData ikon;
  final String judul;
  final String penjelasan;
  final String? labelAksi;
  final VoidCallback? onAksi;

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;
    final teks = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: skema.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(ikon, size: 40, color: skema.onPrimaryContainer),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(judul, style: teks.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: AppSpacing.sm),
            Text(
              penjelasan,
              style: teks.bodyMedium?.copyWith(color: skema.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            if (labelAksi != null) ...[
              const SizedBox(height: AppSpacing.lg),
              FilledButton(onPressed: onAksi, child: Text(labelAksi!)),
            ],
          ],
        ),
      ),
    );
  }
}
