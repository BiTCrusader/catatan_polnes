import 'dart:async';
import 'package:flutter/material.dart';

class KolomPencarian extends StatefulWidget {
  const KolomPencarian({super.key, required this.onBerubah});

  final ValueChanged<String> onBerubah;

  @override
  State<KolomPencarian> createState() => _KolomPencarianState();
}

class _KolomPencarianState extends State<KolomPencarian> {
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
      widget.onBerubah(_kontroler.text);
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
    return TextField(
      controller: _kontroler,
      decoration: const InputDecoration(
        hintText: 'Cari catatan...',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(),
      ),
    );
  }
}
