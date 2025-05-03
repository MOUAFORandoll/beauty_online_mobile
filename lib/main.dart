import 'package:beauty/firebase_options.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:potatoes/potatoes.dart' hide PreferencesService;
import 'package:potatoes_secured_preferences/potatoes_secured_preferences.dart';
import 'package:beauty/auth/bloc/auth_cubit.dart';
import 'package:beauty/auth/screens/onboarding_screen.dart';
import 'package:beauty/auth/services/auth_service.dart';
import 'package:beauty/common/bloc/home_bottom_navigation_cubit.dart';
import 'package:beauty/common/bloc/server_time_cubit.dart';
import 'package:beauty/common/bloc/user_cubit.dart'; 
import 'package:beauty/common/screens/home.dart';
import 'package:beauty/common/services/api_service.dart';
import 'package:beauty/common/services/cache_manager.dart';
import 'package:beauty/common/services/preferences_service.dart';
import 'package:beauty/common/services/user_service.dart';
import 'package:beauty/common/widgets/read_more_theme.dart';
import 'package:beauty/utils/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  imageCache.maximumSizeBytes = 1024 * 1024 * 300;
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage(
      aOptions:
          (() => const AndroidOptions(encryptedSharedPreferences: true))());
  final cacheOptions = await cacheStoreOptions();
  Links.instance = const ApiLinks();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
  CubitErrorState.stream().listen((state) {
    FirebaseCrashlytics.instance.recordError(state.error, state.trace);
  });
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (Object error, StackTrace trace) {
    FirebaseCrashlytics.instance.recordError(error, trace);
    return true;
  };
  runApp(Phoenix(
    child: MyApp(
      navigatorKey: GlobalKey(),
      preferences: preferences,
      secureStorage: secureStorage,
      cacheOptions: cacheOptions,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final SharedPreferences preferences;
  final FlutterSecureStorage secureStorage;
  final CacheOptions cacheOptions;
  const MyApp(
      {required this.navigatorKey,
      required this.preferences,
      required this.secureStorage,
      required this.cacheOptions,
      super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesService = PreferencesService(
      preferences,
      secureStorage,
    );

    final Dio dio = DioClient.instance(
      preferencesService,
      connectTimeout: const Duration(minutes: 1),
    );
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ServerTimeService(dio)),
        RepositoryProvider(create: (_) => AppCacheManager()),
        RepositoryProvider(create: (_) => AuthService(dio)),
        RepositoryProvider(create: (_) => UserService(dio)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ServerTimeCubit(context.read())),
          BlocProvider(create: (_) => HomeBottomNavigationCubit()),
          BlocProvider(
              create: (context) => UserCubit(
                    context.read(),
                    preferencesService,
                  )),
          BlocProvider(
              create: (context) => AuthCubit(context.read(), context.read())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'beauty!',
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          themeMode: ThemeMode.light,
          locale: const Locale.fromSubtags(languageCode: 'fr'),
          supportedLocales: const [Locale.fromSubtags(languageCode: 'fr')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) => BlocListener<UserCubit, UserState>(
            listenWhen: (previous, state) {
              return (previous is UserLoggingOut || previous is UserDeleting) &&
                  state is UserNotLoggedState;
            },
            listener: (_, state) {
              // recharge l'app quelque soit l'étape dans l'appli
              if (state is UserNotLoggedState) {
                Future.delayed(
                    const Duration(milliseconds: 100),
                    // ignore: use_build_context_synchronously
                    () => Phoenix.rebirth(context));
              }
            },
            child: ReadMoreTheme(
              themeData: AppTheme.readMoreThemeData(context),
              child: child ?? SizedBox(),
            ),
          ),
          home: Builder(builder: (context) {
            return BlocBuilder<UserCubit, UserState>(
              buildWhen: (previous, _) => previous is InitializingUserState,
              builder: (context, state) {
                if (state is InitializingUserState) {
                  return const SizedBox();
                }
                if (state is UserNotLoggedState) {
                  return const OnboardingScreen();
                }

                if (state is UserLoggedState) return const HomeScreen();
                return const OnboardingScreen();
              },
            );
          }),
        ),
      ),
    );
  }
}
