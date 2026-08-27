import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_polnes/domain/entity/catatan.dart';

void main() {
  group('Catatan - Dasar & Validasi', () {
    test('konstruktor baru memangkas spasi pada judul', () {
      final c = Catatan.baru(judul: '  Rapat  ', isi: 'Agenda');
      expect(c.judul, 'Rapat');
    });

    test('judul kosong dianggap tidak valid', () {
      final c = Catatan.baru(judul: '   ', isi: 'Agenda');
      expect(c.judulValid, isFalse);
    });

    test('judul 81 karakter dianggap tidak valid', () {
      final c = Catatan.baru(judul: 'a' * 81, isi: '');
      expect(c.judulValid, isFalse);
    });

    test('copyWith hanya mengubah field yang diberikan', () {
      final asli = Catatan.baru(judul: 'A', isi: 'B');
      final ubah = asli.copyWith(judul: 'C');
      expect(ubah.judul, 'C');
      expect(ubah.isi, 'B');
      expect(ubah.id, asli.id);
    });

    test('dua catatan dengan isi sama dianggap setara', () {
      final waktu = DateTime(2026, 8, 1);
      final a = Catatan(id: '1', judul: 'A', isi: 'B', dibuatPada: waktu);
      final b = Catatan(id: '1', judul: 'A', isi: 'B', dibuatPada: waktu);
      expect(a, equals(b));
      expect(a.hashCode, equals(b.hashCode));
      expect({a, b}.length, 1);
    });
  });

  group('Catatan - Latihan 2.2 (Fitur Baru)', () {
    test('ringkasan memotong isi jika lebih dari 50 karakter', () {
      final teksPanjang = 'a' * 60;
      final c = Catatan.baru(judul: 'Tes', isi: teksPanjang);
      expect(c.ringkasan, '${'a' * 50}...');
    });

    test('ringkasan mengembalikan isi utuh jika <= 50 karakter', () {
      final c = Catatan.baru(judul: 'Tes', isi: 'Catatan pendek');
      expect(c.ringkasan, 'Catatan pendek');
    });

    test('baruSaja bernilai true untuk catatan baru dibuat', () {
      final c = Catatan.baru(judul: 'Tes', isi: 'Isi');
      expect(c.baruSaja, isTrue);
    });

    test('baruSaja bernilai false untuk catatan yang dibuat 25 jam lalu', () {
      final lampau = DateTime.now().subtract(const Duration(hours: 25));
      final c = Catatan(id: '1', judul: 'Tes', isi: 'Isi', dibuatPada: lampau);
      expect(c.baruSaja, isFalse);
    });

    test('uji serialisasi bolak-balik Catatan.fromMap(c.toMap()) == c', () {
      final waktu = DateTime.parse('2026-08-27T10:00:00.000Z');
      final c1 = Catatan(
        id: '101',
        judul: 'Rapat',
        isi: 'Membahas materi praktikum',
        dibuatPada: waktu,
        disematkan: true,
      );

      final map = c1.toMap();
      final c2 = Catatan.fromMap(map);

      expect(c2, equals(c1));
    });
  });
}
