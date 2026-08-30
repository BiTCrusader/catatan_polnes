import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catatan_polnes/domain/entity/catatan.dart';
import 'package:catatan_polnes/presentation/state/daftar_catatan_notifier.dart';

void main() {
  group('Unit Test Model Catatan', () {
    // 1. Kasus Normal: Membuat catatan valid
    test('1. [Normal] Membuat Catatan baru dengan data valid', () {
      final catatan = Catatan.baru(judul: 'Judul Valid', isi: 'Isi catatan');
      expect(catatan.judul, 'Judul Valid');
      expect(catatan.judulValid, isTrue);
    });

    // 2. Kasus Batas: Judul tepat 80 karakter
    test('2. [Batas] Judul dengan panjang tepat 80 karakter dianggap valid', () {
      final judul80 = 'A' * 80;
      final catatan = Catatan.baru(judul: judul80, isi: 'Isi');
      expect(catatan.judulValid, isTrue);
    });

    // 3. Kasus Gagal: Judul kosong
    test('3. [Gagal] Judul kosong dianggap tidak valid', () {
      final catatan = Catatan.baru(judul: '', isi: 'Isi');
      expect(catatan.judulValid, isFalse);
    });

    // 4. Kasus Gagal: Judul melebihi 80 karakter
    test('4. [Gagal] Judul melebihi 80 karakter dianggap tidak valid', () {
      final judul81 = 'A' * 81;
      final catatan = Catatan.baru(judul: judul81, isi: 'Isi');
      expect(catatan.judulValid, isFalse);
    });

    // 5. Kasus Batas: Judul hanya berisi spasi (whitespaces)
    test('5. [Batas] Judul hanya berupa spasi dianggap tidak valid', () {
      final catatan = Catatan.baru(judul: '   ', isi: 'Isi');
      expect(catatan.judulValid, isFalse);
    });
  });

  group('Unit Test DaftarCatatanNotifier', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    // 6. Kasus Normal: Menambah catatan valid ke notifier
    test('6. [Normal] Tambah catatan valid meningkatkan jumlah state', () async {
      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      await notifier.tambah('Judul Baru', 'Isi Baru');

      final state = container.read(daftarCatatanNotifierProvider);
      expect(state.value?.length, equals(2)); // 1 data bawaan + 1 data baru
      expect(state.value?.first.judul, equals('Judul Baru'));
    });

    // 7. Kasus Gagal: Menambah catatan dengan judul tidak valid
    test('7. [Gagal] Tambah catatan dengan judul kosong tidak mengubah state', () async {
      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      await notifier.tambah('', 'Isi');

      final state = container.read(daftarCatatanNotifierProvider);
      expect(state.value?.length, equals(1)); // Jumlah tetap sama (hanya data bawaan)
    });

    // 8. Kasus Normal: Menghapus catatan berdasarkan ID
    test('8. [Normal] Hapus catatan berhasil mengurangi state', () async {
      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      final daftarAwal = container.read(daftarCatatanNotifierProvider).value!;
      final idDihapus = daftarAwal.first.id;

      await notifier.hapus(idDihapus);

      final stateSetelahHapus = container.read(daftarCatatanNotifierProvider).value!;
      expect(stateSetelahHapus.any((c) => c.id == idDihapus), isFalse);
    });

    // 9. Kasus Normal: Menambah kembali objek Catatan (Fitur Undo)
    test('9. [Normal] tambahObjek menambahkan kembali catatan utuh ke state', () async {
      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      final catatanUndo = Catatan.baru(judul: 'Catatan Undo', isi: 'Restore');

      await notifier.tambahObjek(catatanUndo);

      final state = container.read(daftarCatatanNotifierProvider).value!;
      expect(state.contains(catatanUndo), isTrue);
    });

    // 10. Kasus Batas: Menghapus ID yang tidak ada di state
    test('10. [Batas] Hapus dengan ID yang tidak ditemukan tidak mengubah isi state', () async {
      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      final jumlahAwal = container.read(daftarCatatanNotifierProvider).value!.length;

      await notifier.hapus('id_tidak_ditemukan_999');

      final jumlahAkhir = container.read(daftarCatatanNotifierProvider).value!.length;
      expect(jumlahAkhir, equals(jumlahAwal));
    });
  });
}