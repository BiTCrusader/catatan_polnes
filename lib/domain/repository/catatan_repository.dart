import '../entity/catatan.dart';

abstract interface class CatatanRepository {
  List<Catatan> ambilSemua();
  void tambah(Catatan catatan);
  void hapus(String id);
}
