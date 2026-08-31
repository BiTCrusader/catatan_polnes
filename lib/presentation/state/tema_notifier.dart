import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Notifier untuk mengelola state ThemeMode (Sistem, Terang, Gelap)
class TemaNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system; // Default mengikuti pengaturan HP

  void ubahTema(ThemeMode modeBaru) {
    state = modeBaru;
  }
}

final temaNotifierProvider = NotifierProvider<TemaNotifier, ThemeMode>(
  TemaNotifier.new,
);