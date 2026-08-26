import 'package:flutter/material.dart';

class LayarDetail extends StatelessWidget {
  const LayarDetail({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail $id')),
      body: Center(child: Text('Catatan dengan id: $id')),
    );
  }
}
