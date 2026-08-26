import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/catatan_repository_memori.dart';
import '../../domain/entity/catatan.dart';
import '../../domain/repository/catatan_repository.dart';

final catatanRepositoryProvider = Provider<CatatanRepository>((ref) {
  return CatatanRepositoryMemori();
});

class DaftarCatatanNotifier extends Notifier<List<Catatan>> {
  @override
  List<Catatan> build() {
    return ref.watch(catatanRepositoryProvider).ambilSemua();
  }

  void tambah(String judul, String isi) {
    final baru = Catatan.baru(judul: judul, isi: isi);
    if (!baru.judulValid) return;

    ref.read(catatanRepositoryProvider).tambah(baru);
    state = [baru, ...state];
  }

  void hapus(String id) {
    ref.read(catatanRepositoryProvider).hapus(id);
    state = state.where((c) => c.id != id).toList();
  }
}

final daftarCatatanProvider =
    NotifierProvider<DaftarCatatanNotifier, List<Catatan>>(
      DaftarCatatanNotifier.new,
    );
