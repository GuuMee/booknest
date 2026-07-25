// lib/app.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';       // MultiBlocProvider
import 'package:go_router/go_router.dart';             // GoRouter, routerConfig

import 'core/navigation/app_router.dart';              // AppRouter.router
import 'core/navigation/navigator_key.dart';           // navigatorKey
import 'core/theme/app_theme.dart';                    // AppTheme.light
import 'domain/repositories/search_repository.dart';  // SearchRepository
import 'data/repositories/search_repository_impl.dart'; // SearchRepositoryImpl
import 'presentation/blocs/search/search_bloc.dart';  // SearchBloc
import 'presentation/blocs/favorites/favorites_bloc.dart'; // FavoritesBloc

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        // ── Repositories ───────────────────
        RepositoryProvider<SearchRepository>(
          create: (_) => SearchRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          // ── BLoCs ──────────────────────────
          BlocProvider<SearchBloc>(
            create: (ctx) => SearchBloc(
              searchRepository:
                  ctx.read<SearchRepository>(),
            ),
          ),
          BlocProvider<FavoritesBloc>(
            create: (_) => FavoritesBloc(),
          ),
        ],
        child: MaterialApp.router(
          // ── Router ───────────────────────
          routerConfig: AppRouter.router,

          // ── Meta ─────────────────────────
          title: 'BookNest',
          debugShowCheckedModeBanner: false,

          // ── Theme ────────────────────────
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: ThemeMode.system,
        ),
      ),
    );
  }
}