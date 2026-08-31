import 'package:flutter/material.dart';
import '../../domain/entity/catatan.dart';
import '../theme/tokens.dart';

class KartuCatatan extends StatelessWidget {
  const KartuCatatan({
    super.key,
    required this.catatan,
    required this.onKetuk,
    required this.onHapus,
  });

  final Catatan catatan;
  final VoidCallback onKetuk;
  final VoidCallback onHapus;

  String _formatTanggal(DateTime dt) {
    final bulan = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    final hari = dt.day.toString().padLeft(2, '0');
    final namaBulan = bulan[dt.month - 1];
    return '$hari $namaBulan ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;

    // 📍 LANGKAH 8a: Bungkus seluruh kartu dengan Semantics untuk aksesibilitas (Screen Reader/TalkBack)
    return Semantics(
      label:
          'Catatan ${catatan.judul}, dibuat ${_formatTanggal(catatan.dibuatPada)}'
          '${catatan.disematkan ? ", disematkan" : ""}',
      button: true,
      onTapHint: 'membuka detail catatan',
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: InkWell(
          onTap: onKetuk,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        catatan.judul,
                        style: teks.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (catatan.disematkan)
                      const Icon(Icons.push_pin, size: 18),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      onPressed: onHapus,
                      tooltip:
                          'Hapus Catatan', // 📍 LANGKAH 8b: Tooltip untuk ikon
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  catatan.isi,
                  style: teks.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _formatTanggal(catatan.dibuatPada),
                  style: teks.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
