import '../../domain/entity/catatan.dart';
import '../../domain/repository/catatan_repository.dart';

class CatatanRepositoryMemori implements CatatanRepository {
  // Isi data awal di sini agar layar tidak kosong
  final List<Catatan> _data = [
    Catatan.baru(
      judul: 'Praktikum Flutter',
      isi: 'Mempelajari State Management Riverpod di POLNES.',
    ),
  ];

  @override
  List<Catatan> ambilSemua() => List.unmodifiable(_data);

  @override
  void tambah(Catatan catatan) => _data.add(catatan);

  @override
  void hapus(String id) => _data.removeWhere((c) => c.id == id);
}