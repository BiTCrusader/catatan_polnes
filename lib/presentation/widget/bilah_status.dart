import 'package:flutter/material.dart';
import '../theme/tokens.dart';

enum JenisBilahStatus { info, peringatan, galat }

class BilahStatus extends StatelessWidget {
  const BilahStatus({
    super.key,
    required this.pesan,
    required this.jenis,
  });

  final String pesan;
  final JenisBilahStatus jenis;

  @override
  Widget build(BuildContext context) {
    final skema = Theme.of(context).colorScheme;

    // Menentukan warna latar, warna teks, dan ikon berdasarkan jenis
    final Color warnaLatar;
    final Color warnaTeks;
    final IconData ikon;

    switch (jenis) {
      case JenisBilahStatus.info:
        warnaLatar = skema.primaryContainer;
        warnaTeks = skema.onPrimaryContainer;
        ikon = Icons.info_outline;
        break;
      case JenisBilahStatus.peringatan:
        warnaLatar = skema.tertiaryContainer;
        warnaTeks = skema.onTertiaryContainer;
        ikon = Icons.warning_amber_rounded;
        break;
      case JenisBilahStatus.galat:
        warnaLatar = skema.errorContainer;
        warnaTeks = skema.onErrorContainer;
        ikon = Icons.error_outline;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        children: [
          Icon(ikon, color: warnaTeks, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              pesan,
              style: TextStyle(color: warnaTeks, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}