import 'package:flutter/material.dart';
import '../theme/tokens.dart';

class SkeletonDaftar extends StatelessWidget {
  const SkeletonDaftar({super.key});

  @override
  Widget build(BuildContext context) {
    final warna = Theme.of(context).colorScheme.surfaceContainerHighest;

    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            color: warna,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
        );
      },
    );
  }
}
