import 'package:go_router/go_router.dart';
import '../layar/layar_beranda.dart';
import '../layar/layar_detail.dart';
import '../layar/beranda_responsif.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: 'beranda',
      builder: (context, state) => const BerandaResponsif(
        daftar: LayarBeranda(),
        detail: LayarDetail(
          id: '',
        ), // Tampilan detail default (kosong/pilih catatan)
      ),
      routes: [
        GoRoute(
          path: 'catatan/:id',
          name: 'detailCatatan',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return LayarDetail(id: id);
          },
        ),
      ],
    ),
  ],
);
