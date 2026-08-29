import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/catatan.dart';
import '../state/daftar_catatan_notifier.dart';
import '../widget/kartu_catatan.dart';
import '../widget/kolom_pencarian.dart';
import 'layar_formulir.dart';

class LayarBeranda extends ConsumerWidget {
  const LayarBeranda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: _AppBarBeranda(),
      body: _KontenDaftarCatatan(),
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

// --- EXTRACT WIDGET 2: Konten Daftar Catatan (dengan AsyncValue.when) ---
class _KontenDaftarCatatan extends ConsumerWidget {
  const _KontenDaftarCatatan();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCatatan = ref.watch(daftarCatatanTersaringProvider);

    return asyncCatatan.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Terjadi galat: $err')),
      data: (daftarCatatan) {
        if (daftarCatatan.isEmpty) {
          return const Center(child: Text('Tidak ada catatan ditemukan'));
        }
        return ListView.builder(
          itemCount: daftarCatatan.length,
          itemBuilder: (context, index) {
            final catatan = daftarCatatan[index];
            return KartuCatatan(
              catatan: catatan,
              onKetuk: () {},
              onHapus: () => _prosesHapus(context, ref, catatan),
            );
          },
        );
      },
    );
  }

  void _prosesHapus(BuildContext context, WidgetRef ref, Catatan catatan) {
    ref.read(daftarCatatanNotifierProvider.notifier).hapus(catatan.id);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Catatan "${catatan.judul}" dihapus'),
        action: SnackBarAction(
          label: 'Urungkan',
          onPressed: () {
            ref
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
      onPressed: () async {
        final hasil = await Navigator.push<Map<String, String>>(
          context,
          MaterialPageRoute(
            builder: (context) => const LayarFormulir(),
          ),
        );

        if (hasil != null) {
          final judul = hasil['judul'] ?? '';
          final isi = hasil['isi'] ?? '';

          ref
              .read(daftarCatatanNotifierProvider.notifier)
              .tambah(judul, isi);
        }
      },
      child: const Icon(Icons.add),
    );
  }
}