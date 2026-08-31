import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/catatan_repository_memori.dart';
import '../../domain/entity/catatan.dart';
import '../../domain/repository/catatan_repository.dart';

final catatanRepositoryProvider = Provider<CatatanRepository>((ref) {
  return CatatanRepositoryMemori();
});

class DaftarCatatanNotifier extends AsyncNotifier<List<Catatan>> {
  @override
  FutureOr<List<Catatan>> build() async {
    await Future.delayed(const Duration(seconds: 1));
    return ref.watch(catatanRepositoryProvider).ambilSemua();
  }

  Future<void> tambah(String judul, String isi) async {
    final baru = Catatan.baru(judul: judul, isi: isi);
    if (!baru.judulValid) return;

    ref.read(catatanRepositoryProvider).tambah(baru);
    state = AsyncData([baru, ...?state.value]);
  }

  Future<void> tambahObjek(Catatan catatan) async {
    ref.read(catatanRepositoryProvider).tambah(catatan);
    state = AsyncData([...state.value ?? [], catatan]);
  }

  Future<void> hapus(String id) async {
    ref.read(catatanRepositoryProvider).hapus(id);
    state = AsyncData(
      (state.value ?? []).where((c) => c.id != id).toList(),
    );
  }
}

final daftarCatatanNotifierProvider =
AsyncNotifierProvider<DaftarCatatanNotifier, List<Catatan>>(
  DaftarCatatanNotifier.new,
);

// 📍 NOTIFIER KATA KUNCI PENCARIAN (Dengan metode ubah)
class KataKunciPencarianNotifier extends Notifier<String> {
  @override
  String build() => '';

  // 📍 Metode ini yang dipanggil oleh KolomPencarian
  void ubah(String baru) {
    state = baru;
  }
}

final kataKunciPencarianProvider =
NotifierProvider<KataKunciPencarianNotifier, String>(
  KataKunciPencarianNotifier.new,
);

// Provider turunan untuk menyaring daftar catatan
final daftarCatatanTersaringProvider = Provider<AsyncValue<List<Catatan>>>((ref) {
  final asyncCatatan = ref.watch(daftarCatatanNotifierProvider);
  final kataKunci = ref.watch(kataKunciPencarianProvider);

  return asyncCatatan.whenData((daftar) {
    final pencarian = kataKunci.trim().toLowerCase();

    if (pencarian.isEmpty) return daftar;

    return daftar.where((catatan) {
      final judulSesuai = catatan.judul.toLowerCase().contains(pencarian);
      final isiSesuai = catatan.isi.toLowerCase().contains(pencarian);
      return judulSesuai || isiSesuai;
    }).toList();
  });
});