import '../../domain/entity/catatan.dart';
import '../../domain/repository/catatan_repository.dart';

class CatatanRepositoryMemori implements CatatanRepository {
  final List<Catatan> _data = [];

  @override
  List<Catatan> ambilSemua() => List.unmodifiable(_data);

  @override
  void tambah(Catatan catatan) => _data.add(catatan);

  @override
  void hapus(String id) => _data.removeWhere((c) => c.id == id);
}
