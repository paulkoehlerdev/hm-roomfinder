import 'package:go_router/go_router.dart';
import 'package:survey/presentation/home/home_screen.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    name: 'home',
    path: '/',
    builder: (context, state) => const HomeScreen(),
  )
]);
