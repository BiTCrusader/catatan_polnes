import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../state/daftar_catatan_notifier.dart';
import '../widget/kartu_catatan.dart';

class LayarBeranda extends ConsumerWidget {
  const LayarBeranda({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catatan = ref.watch(daftarCatatanProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catatan POLNES')),
      body: catatan.isEmpty
          ? const Center(child: Text('Belum ada catatan'))
          : ListView.builder(
              itemCount: catatan.length,
              itemBuilder: (context, i) => KartuCatatan(
                key: ValueKey(catatan[i].id),
                catatan: catatan[i],
                onKetuk: () => context.pushNamed(
                  'detailCatatan',
                  pathParameters: {'id': catatan[i].id},
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(daftarCatatanProvider.notifier)
            .tambah('Catatan ${catatan.length + 1}', 'Isi contoh'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
