import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/daftar_catatan_notifier.dart';
import '../theme/tokens.dart';

class KolomPencarian extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const KolomPencarian({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  ConsumerState<KolomPencarian> createState() => _KolomPencarianState();
}

class _KolomPencarianState extends ConsumerState<KolomPencarian> {
  late final TextEditingController _kontroler;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _kontroler = TextEditingController();
    _kontroler.addListener(_tunda);
  }

  void _tunda() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      ref.read(kataKunciPencarianProvider.notifier).ubah(_kontroler.text);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _kontroler.removeListener(_tunda);
    _kontroler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: TextField(
        controller: _kontroler,
        decoration: InputDecoration(
          hintText: 'Cari catatan...',
          prefixIcon: const Icon(Icons.search),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
      ),
    );
  }
}