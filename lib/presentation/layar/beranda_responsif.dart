import 'package:flutter/material.dart';
import '../theme/tokens.dart';

class BerandaResponsif extends StatelessWidget {
  const BerandaResponsif({
    super.key,
    required this.daftar,
    required this.detail,
  });

  final Widget daftar;
  final Widget detail;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, kendala) {
        if (kendala.maxWidth >= AppBreakpoint.medium) {
          return Scaffold(
            body: Row(
              children: [
                SizedBox(width: 360, child: daftar),
                const VerticalDivider(width: 1),
                Expanded(child: detail),
              ],
            ),
          );
        }
        return daftar;
      },
    );
  }
}
