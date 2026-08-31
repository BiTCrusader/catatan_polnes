import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:catatan_polnes/domain/entity/catatan.dart';
import 'package:catatan_polnes/presentation/state/daftar_catatan_notifier.dart';

void main() {
  group('Unit Test Model Catatan', () {
    test('1. [Normal] Membuat Catatan baru dengan data valid', () {
      final catatan = Catatan.baru(judul: 'Judul Valid', isi: 'Isi catatan');
      expect(catatan.judul, 'Judul Valid');
      expect(catatan.judulValid, isTrue);
    });

    test('2. [Batas] Judul dengan panjang tepat 80 karakter dianggap valid', () {
      final judul80 = 'A' * 80;
      final catatan = Catatan.baru(judul: judul80, isi: 'Isi');
      expect(catatan.judulValid, isTrue);
    });

    test('3. [Gagal] Judul kosong dianggap tidak valid', () {
      final catatan = Catatan.baru(judul: '', isi: 'Isi');
      expect(catatan.judulValid, isFalse);
    });

    test('4. [Gagal] Judul melebihi 80 karakter dianggap tidak valid', () {
      final judul81 = 'A' * 81;
      final catatan = Catatan.baru(judul: judul81, isi: 'Isi');
      expect(catatan.judulValid, isFalse);
    });

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

    test('6. [Normal] Tambah catatan valid meningkatkan jumlah state', () async {
      // Tunggu pemuatan awal selesai
      await container.read(daftarCatatanNotifierProvider.future);

      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      await notifier.tambah('Judul Baru', 'Isi Baru');

      final state = await container.read(daftarCatatanNotifierProvider.future);
      expect(state.length, equals(2));
      expect(state.first.judul, equals('Judul Baru'));
    });

    test('7. [Gagal] Tambah catatan dengan judul kosong tidak mengubah state', () async {
      await container.read(daftarCatatanNotifierProvider.future);

      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      await notifier.tambah('', 'Isi');

      final state = await container.read(daftarCatatanNotifierProvider.future);
      expect(state.length, equals(1));
    });

    test('8. [Normal] Hapus catatan berhasil mengurangi state', () async {
      final daftarAwal = await container.read(daftarCatatanNotifierProvider.future);
      final idDihapus = daftarAwal.first.id;

      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      await notifier.hapus(idDihapus);

      final stateSetelahHapus = await container.read(daftarCatatanNotifierProvider.future);
      expect(stateSetelahHapus.any((c) => c.id == idDihapus), isFalse);
    });

    test('9. [Normal] tambahObjek menambahkan kembali catatan utuh ke state', () async {
      await container.read(daftarCatatanNotifierProvider.future);

      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      final catatanUndo = Catatan.baru(judul: 'Catatan Undo', isi: 'Restore');

      await notifier.tambahObjek(catatanUndo);

      final state = await container.read(daftarCatatanNotifierProvider.future);
      expect(state.contains(catatanUndo), isTrue);
    });

    test('10. [Batas] Hapus dengan ID yang tidak ditemukan tidak mengubah isi state', () async {
      final daftarAwal = await container.read(daftarCatatanNotifierProvider.future);
      final jumlahAwal = daftarAwal.length;

      final notifier = container.read(daftarCatatanNotifierProvider.notifier);
      await notifier.hapus('id_tidak_ditemukan_999');

      final stateAkhir = await container.read(daftarCatatanNotifierProvider.future);
      expect(stateAkhir.length, equals(jumlahAwal));
    });
  });
}