import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/catatan.dart';
import '../state/daftar_catatan_notifier.dart';
import '../theme/tokens.dart';
import '../widget/kartu_catatan.dart';
import '../widget/keadaan_kosong.dart';
import '../widget/kolom_pencarian.dart';
import '../widget/skeleton_daftar.dart';
import 'layar_formulir.dart';

class LayarBeranda extends ConsumerWidget {
  const LayarBeranda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 📍 Menambahkan const pada Scaffold (Line 17)
    return const Scaffold(
      appBar: _AppBarBeranda(),
      body: KontenDaftarCatatan(),
      floatingActionButton: _TombolTambahCatatan(),
    );
  }
}

// --- EXTRACT WIDGET 1: AppBar + KolomPencarian ---
class _AppBarBeranda extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarBeranda();

  @override
  Size get preferredSize => const Size.fromHeight(116);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Catatan POLNES'),
      bottom: const KolomPencarian(),
    );
  }
}

// --- EXTRACT WIDGET 2: Konten Daftar Catatan ---
class KontenDaftarCatatan extends ConsumerWidget {
  const KontenDaftarCatatan({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCatatan = ref.watch(daftarCatatanTersaringProvider);

    return asyncCatatan.when(
      loading: () => const SkeletonDaftar(),
      error: (err, stack) => Center(child: Text('Terjadi galat: $err')),
      data: (daftarCatatan) {
        if (daftarCatatan.isEmpty) {
          return const KeadaanKosong(
            ikon: Icons.note_add_outlined,
            judul: 'Belum ada catatan',
            penjelasan:
            'Ketuk tombol tambah untuk membuat catatan pertama Anda.',
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          itemCount: daftarCatatan.length,
          itemBuilder: (context, index) {
            final catatan = daftarCatatan[index];
            return KartuCatatan(
              key: ValueKey(catatan.id),
              catatan: catatan,
              onKetuk: () {},
              // 📍 Menggunakan async/await agar tidak unawaited
              onHapus: () async => await _prosesHapus(context, ref, catatan),
            );
          },
        );
      },
    );
  }

  Future<void> _prosesHapus(
      BuildContext context, WidgetRef ref, Catatan catatan) async {
    // 📍 Menambahkan await di sini (Line 118)
    await ref.read(daftarCatatanNotifierProvider.notifier).hapus(catatan.id);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Catatan "${catatan.judul}" dihapus'),
        action: SnackBarAction(
          label: 'Urungkan',
          onPressed: () async {
            await ref
                .read(daftarCatatanNotifierProvider.notifier)
                .tambahObjek(catatan);
          },
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }
}

// --- EXTRACT WIDGET 3: Tombol Tambah Catatan ---
class _TombolTambahCatatan extends ConsumerWidget {
  const _TombolTambahCatatan();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      tooltip: 'Tambah catatan',
      onPressed: () async {
        final hasil = await Navigator.push<Map<String, String>>(
          context,
          MaterialPageRoute(builder: (context) => const LayarFormulir()),
        );

        if (hasil != null) {
          final judul = hasil['judul'] ?? '';
          final isi = hasil['isi'] ?? '';

          await ref
              .read(daftarCatatanNotifierProvider.notifier)
              .tambah(judul, isi);
        }
      },
      child: const Icon(Icons.add),
    );
  }
}