// lib/main.dart

import 'package:firebase_core/firebase_core.dart';        // Firebase.initializeApp()
import 'package:firebase_messaging/firebase_messaging.dart'; // FirebaseMessaging
                                                             // RemoteMessage
                                                             // background handler
import 'package:flutter/material.dart';                   // WidgetsFlutterBinding
                                                          // runApp
                                                          // Colors
                                                          // debugPrint
import 'package:flutter/services.dart';                   // SystemChrome
                                                          // SystemUiOverlayStyle
                                                          // DeviceOrientation
import 'package:hive_flutter/hive_flutter.dart';          // Hive.initFlutter()
                                                          // Hive.openBox()
import 'package:timezone/data/latest.dart' as tz;        // tz.initializeTimeZones()
import 'package:shared_preferences/shared_preferences.dart'; // ✅ ADDED
                                                             // SharedPreferences
import 'package:firebase_auth/firebase_auth.dart';        // ✅ ADDED
                                                          // FirebaseAuth
import 'package:cloud_firestore/cloud_firestore.dart';    // ✅ ADDED
                                                          // FirebaseFirestore
import 'package:flutter_bloc/flutter_bloc.dart';          // ✅ ADDED
                                                          // MultiBlocProvider
                                                          // BlocProvider
                                                          // BlocBuilder

import 'firebase_options.dart';                           // DefaultFirebaseOptions
import 'services/notification_service.dart';              // NotificationService

// Repositories                                           // ✅ ADDED
import 'data/repositories/auth_repository.dart';          // AuthRepository
import 'data/repositories/book_repository.dart';          // BookRepository
import 'data/repositories/stats_repository.dart';         // StatsRepository

// BLoCs                                                  // ✅ ADDED
import 'presentation/blocs/auth/auth_bloc.dart';          // AuthBloc
import 'presentation/blocs/auth/auth_event.dart';         // CheckAuthStatus
import 'presentation/blocs/settings/settings_bloc.dart';  // SettingsBloc
import 'presentation/blocs/settings/settings_event.dart'; // LoadSettings
import 'presentation/blocs/settings/settings_state.dart'; // SettingsState
                                                          // SettingsLoaded
import 'presentation/blocs/stats/stats_bloc.dart';        // StatsBloc
import 'presentation/blocs/book/book_bloc.dart';          // BookBloc
import 'presentation/blocs/library/library_bloc.dart';    // LibraryBloc

// Core - Theme                                           // ✅ ADDED
import 'core/theme/app_theme.dart';                       // AppTheme
                                                          // .lightTheme
                                                          // .darkTheme

// Config - Router                                        // ✅ ADDED
import 'config/routes/app_router.dart';                   // AppRouter
                                                          // .router

// ─────────────────────────────────────────────────────────────────────────────
// BACKGROUND MESSAGE HANDLER
// must be a top-level function
// ─────────────────────────────────────────────────────────────────────────────

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint(
    'Background message: ${message.messageId}',
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// MAIN
// ─────────────────────────────────────────────────────────────────────────────

Future<void> main() async {
  // ── Flutter binding ──────────────────────
  WidgetsFlutterBinding.ensureInitialized();

  // ── Orientation lock ─────────────────────
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // ── Status bar style ─────────────────────
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // ── Firebase ─────────────────────────────
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ── FCM background handler ───────────────
  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  // ── Hive ─────────────────────────────────
  await Hive.initFlutter();
  await Hive.openBox('search_history');
  await Hive.openBox('user_preferences');
  await Hive.openBox('reading_progress');

  // ── Timezone ─────────────────────────────
  tz.initializeTimeZones();

  // ── Notifications ────────────────────────
  await NotificationService().initialize();

  // ── SharedPreferences ────────────────────  // ✅ ADDED
  final prefs =
      await SharedPreferences.getInstance();

  // ── Repositories ─────────────────────────  // ✅ ADDED
  final authRepository = AuthRepository(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );

  final bookRepository = BookRepository(
    firestore: FirebaseFirestore.instance,
  );

  final statsRepository = StatsRepository(
    firestore: FirebaseFirestore.instance,
  );

  // ── Run ──────────────────────────────────
  runApp(
    BookNestApp(
      prefs: prefs,
      authRepository: authRepository,
      bookRepository: bookRepository,
      statsRepository: statsRepository,
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// APP
// ─────────────────────────────────────────────────────────────────────────────

class BookNestApp extends StatelessWidget {       // ✅ ADDED
  final SharedPreferences prefs;
  final AuthRepository authRepository;
  final BookRepository bookRepository;
  final StatsRepository statsRepository;

  const BookNestApp({
    super.key,
    required this.prefs,
    required this.authRepository,
    required this.bookRepository,
    required this.statsRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authRepository: authRepository,
          )..add(CheckAuthStatus()),
        ),
        BlocProvider(
          create: (_) => SettingsBloc(
            prefs: prefs,
            firestore: FirebaseFirestore.instance,
            auth: FirebaseAuth.instance,
          )..add(LoadSettings()),
        ),
        BlocProvider(
          create: (_) => StatsBloc(
            statsRepository: statsRepository,
            auth: FirebaseAuth.instance,
          ),
        ),
        BlocProvider(
          create: (_) => BookBloc(
            bookRepository: bookRepository,
          ),
        ),
        BlocProvider(
          create: (_) => LibraryBloc(
            bookRepository: bookRepository,
            auth: FirebaseAuth.instance,
          ),
        ),
      ],
      child: BlocBuilder<SettingsBloc,
          SettingsState>(
        buildWhen: (prev, curr) {
          if (prev is SettingsLoaded &&
              curr is SettingsLoaded) {
            return prev.settings.appTheme !=
                curr.settings.appTheme;
          }
          return true;
        },
        builder: (context, settingsState) {
          ThemeMode themeMode =
              ThemeMode.system;

          if (settingsState is SettingsLoaded) {
            switch (
                settingsState.settings.appTheme) {
              case 'light':
                themeMode = ThemeMode.light;
                break;
              case 'dark':
                themeMode = ThemeMode.dark;
                break;
              default:
                themeMode = ThemeMode.system;
            }
          }

          return MaterialApp.router(
            title: 'BookNest',
            debugShowCheckedModeBanner: false,
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}