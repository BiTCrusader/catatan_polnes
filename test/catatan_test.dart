import 'package:flutter_test/flutter_test.dart';
import 'package:catatan_polnes/domain/entity/catatan.dart';

void main() {
  group('Catatan', () {
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
}
