import 'package:flutter/material.dart';
import '../../domain/entity/catatan.dart';

class KartuCatatan extends StatelessWidget {
  const KartuCatatan({super.key, required this.catatan, required this.onKetuk});

  final Catatan catatan;
  final VoidCallback onKetuk;

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
                ],
              ),
              const SizedBox(height: 6),
              Text(
                catatan.isi,
                style: teks.bodyMedium,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
