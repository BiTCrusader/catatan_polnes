class Catatan {
  final String id;
  final String judul;
  final String isi;
  final DateTime dibuatPada;
  final bool disematkan;

  const Catatan({
    required this.id,
    required this.judul,
    required this.isi,
    required this.dibuatPada,
    this.disematkan = false,
  });

  // Factory constructor untuk membuat catatan baru dengan ID & waktu otomatis
  factory Catatan.baru({
    required String judul,
    required String isi,
    bool disematkan = false,
  }) {
    return Catatan(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      judul: judul.trim(),
      isi: isi,
      dibuatPada: DateTime.now(),
      disematkan: disematkan,
    );
  }

  // Getter validasi judul
  bool get judulValid => judul.isNotEmpty && judul.length <= 80;

  // Method copyWith untuk membuat salinan objek dengan bidang yang diubah
  Catatan copyWith({String? judul, String? isi, bool? disematkan}) {
    return Catatan(
      id: id,
      judul: judul ?? this.judul,
      isi: isi ?? this.isi,
      dibuatPada: dibuatPada,
      disematkan: disematkan ?? this.disematkan,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Catatan &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          judul == other.judul &&
          isi == other.isi &&
          dibuatPada == other.dibuatPada &&
          disematkan == other.disematkan;

  @override
  int get hashCode =>
      id.hashCode ^
      judul.hashCode ^
      isi.hashCode ^
      dibuatPada.hashCode ^
      disematkan.hashCode;
}
