import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entity/catatan.dart';
import '../state/daftar_catatan_notifier.dart';
import '../theme/tokens.dart';

class LayarDetail extends ConsumerStatefulWidget {
  const LayarDetail({super.key, required this.id});

  final String id;

  @override
  ConsumerState<LayarDetail> createState() => _LayarDetailState();
}

class _LayarDetailState extends ConsumerState<LayarDetail> {
  late TextEditingController _judulController;
  late TextEditingController _isiController;
  String? _currentLoadedId;

  @override
  void initState() {
    super.initState();
    _judulController = TextEditingController();
    _isiController = TextEditingController();
  }

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  void _simpanDanKembali() {
    final judul = _judulController.text.trim();
    final isi = _isiController.text.trim();

    if (judul.isNotEmpty) {
      // 📍 Mengubah/memperbarui catatan yang ada berdasarkan ID-nya
      ref
          .read(daftarCatatanNotifierProvider.notifier)
          .perbarui(widget.id, judul, isi);

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Catatan diperbarui'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    if (context.mounted && Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncCatatan = ref.watch(daftarCatatanNotifierProvider);

    return asyncCatatan.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (err, stack) => Scaffold(
        appBar: AppBar(),
        body: Center(child: Text('Terjadi kesalahan: $err')),
      ),
      data: (daftar) {
        final Catatan? catatan = daftar.cast<Catatan?>().firstWhere(
              (c) => c?.id == widget.id,
          orElse: () => null,
        );

        if (catatan == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Catatan tidak ditemukan.')),
          );
        }

        if (_currentLoadedId != widget.id) {
          _currentLoadedId = widget.id;
          _judulController.text = catatan.judul;
          _isiController.text = catatan.isi;
        }

        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            final judul = _judulController.text.trim();
            final isi = _isiController.text.trim();
            if (judul.isNotEmpty) {
              ref
                  .read(daftarCatatanNotifierProvider.notifier)
                  .perbarui(widget.id, judul, isi);
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
              actions: [
                IconButton(
                  icon: const Icon(Icons.check),
                  tooltip: 'Simpan',
                  onPressed: _simpanDanKembali,
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _judulController,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Judul',
                        filled: false,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '31 Agu 2026',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Expanded(
                      child: TextField(
                        controller: _isiController,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          height: 1.5,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Mulai mengetik catatan...',
                          filled: false,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}