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

  // 1. Getter ringkasan (50 karakter pertama isi)
  String get ringkasan {
    if (isi.length > 50) {
      return '${isi.substring(0, 50)}...';
    }
    return isi;
  }

  // 2. Getter baruSaja (bernilai true jika dibuat kurang dari 24 jam lalu)
  bool get baruSaja {
    final selisih = DateTime.now().difference(dibuatPada);
    return selisih.inHours < 24 && !selisih.isNegative;
  }

  // 3. Method toMap untuk serialisasi ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'judul': judul,
      'isi': isi,
      'dibuatPada': dibuatPada.toIso8601String(),
      'disematkan': disematkan,
    };
  }

  // 4. Factory fromMap untuk deserialisasi dari Map
  factory Catatan.fromMap(Map<String, dynamic> map) {
    return Catatan(
      id: map['id'] as String,
      judul: map['judul'] as String,
      isi: map['isi'] as String,
      dibuatPada: DateTime.parse(map['dibuatPada'] as String),
      disematkan: map['disematkan'] as bool? ?? false,
    );
  }

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
