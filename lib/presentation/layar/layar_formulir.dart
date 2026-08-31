import 'package:flutter/material.dart';
import '../theme/tokens.dart'; // 📍 Impor Design Tokens

class LayarFormulir extends StatefulWidget {
  const LayarFormulir({super.key});

  @override
  State<LayarFormulir> createState() => _LayarFormulirState();
}

class _LayarFormulirState extends State<LayarFormulir> {
  final _judulController = TextEditingController();
  final _isiController = TextEditingController();

  String? _pesanGalatJudul;
  bool _bisaDisimpan = false;

  @override
  void initState() {
    super.initState();
    _judulController.addListener(_validasiJudul);
  }

  void _validasiJudul() {
    final teks = _judulController.text;

    setState(() {
      if (teks.trim().isEmpty) {
        _pesanGalatJudul = 'Judul tidak boleh kosong';
        _bisaDisimpan = false;
      } else if (teks.length > 80) {
        _pesanGalatJudul = 'Judul tidak boleh melebihi 80 karakter';
        _bisaDisimpan = false;
      } else {
        _pesanGalatJudul = null;
        _bisaDisimpan = true;
      }
    });
  }

  @override
  void dispose() {
    _judulController.dispose();
    _isiController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (_bisaDisimpan) {
      Navigator.pop(context, {
        'judul': _judulController.text,
        'isi': _isiController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Catatan')),
      body: Padding(
        // 📍 Diganti dari 16.0
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                labelText: 'Judul Catatan',
                errorText: _pesanGalatJudul,
                border: const OutlineInputBorder(),
              ),
            ),
            // 📍 Diganti dari 16
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _isiController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Isi Catatan',
                border: OutlineInputBorder(),
              ),
            ),
            // 📍 Diganti dari 24
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _bisaDisimpan ? _simpan : null,
                child: const Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
