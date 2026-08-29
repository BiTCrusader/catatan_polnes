import 'package:flutter/material.dart';
import '../../domain/entity/catatan.dart';

class KartuCatatan extends StatelessWidget {
  const KartuCatatan({
    super.key,
    required this.catatan,
    required this.onKetuk,
    required this.onHapus, // 1. Tambahkan parameter callback hapus
  });

  final Catatan catatan;
  final VoidCallback onKetuk;
  final VoidCallback onHapus; // 2. Deklarasi callback

  // Fungsi pembantu pembentuk format tanggal dd MMM yyyy
  String _formatTanggal(DateTime dt) {
    final bulan = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    final hari = dt.day.toString().padLeft(2, '0');
    final namaBulan = bulan[dt.month - 1];
    return '$hari $namaBulan ${dt.year}';
  }

  @override
  Widget build(BuildContext context) {
    final teks = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: onKetuk,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  if (catatan.disematkan) const Icon(Icons.push_pin, size: 18),
                  // 3. Tombol Hapus
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                    onPressed: onHapus,
                    tooltip: 'Hapus Catatan',
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                catatan.isi,
                style: teks.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              // 4. Tampilkan Tanggal Pembuatan (dd MMM yyyy)
              Text(
                _formatTanggal(catatan.dibuatPada),
                style: teks.bodySmall?.copyWith(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}