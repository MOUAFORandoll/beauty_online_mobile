import 'package:beauty/auth/screens/splash_page.dart';
import 'package:beauty/common/bloc/link_cubit.dart';
import 'package:beauty/common/bloc/select_realisation_cubit.dart';
import 'package:beauty/common/bloc/user_search_cubit.dart';
import 'package:beauty/common/bloc/video_cubit.dart';
import 'package:beauty/common/widgets/app_video_player.dart';
import 'package:beauty/home/services/actu_cubit_manager.dart';
import 'package:beauty/map/bloc/map_tracking_cubit.dart';
import 'package:beauty/map/directions_service.dart';
import 'package:beauty/my_pro/bloc/add_schedule_cubit.dart';
import 'package:beauty/my_pro/bloc/load_me_pro_rendez_vous_cubit.dart';
import 'package:beauty/my_pro/bloc/schedule_cubit.dart' show ScheduleCubit;
import 'package:beauty/my_pro/bloc/gestion_professional_cubit.dart';
import 'package:beauty/my_pro/bloc/load_me_agenda_cubit.dart';
import 'package:beauty/my_pro/bloc/load_me_catalogue_cubit.dart';
import 'package:beauty/Professional/bloc/professional_cubit.dart';
import 'package:beauty/account/bloc/cubit/account_view_manage_cubit.dart';
import 'package:beauty/account/bloc/theme_mode_cubit.dart';
import 'package:beauty/auth/screens/complete_info.dart';
import 'package:beauty/common/services/geolocation_service.dart';
import 'package:beauty/common/services/professional_cubit_manager.dart';
import 'package:beauty/firebase_options.dart';
import 'package:beauty/home/bloc/load_actu_cubit.dart';
import 'package:beauty/home/services/actu_service.dart';
import 'package:beauty/my_pro/bloc/my_professional_cubit.dart';
import 'package:beauty/my_pro/bloc/new_professional_cubit.dart';
import 'package:beauty/my_pro/services/professional_service.dart';
import 'package:beauty/notifications/bloc/load_notifications_cubit.dart';
import 'package:beauty/notifications/bloc/notification_cubit.dart';
import 'package:beauty/notifications/services/notification_service.dart';
import 'package:beauty/notifications/services/notifications_service.dart';
import 'package:beauty/professional/bloc/action_professional_cubit.dart';
import 'package:beauty/professional/bloc/catalogue_cubit_manager.dart';
import 'package:beauty/professional/bloc/load_me_rendez_vous_cubit.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
import 'package:beauty/common/utils/themes.dart';

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
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  runApp(Phoenix(
    child: MyApp(
      navigatorKey: GlobalKey(),
      packageInfo: packageInfo,
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
  final PackageInfo packageInfo;

  const MyApp(
      {required this.navigatorKey,
      required this.packageInfo,
      required this.preferences,
      required this.secureStorage,
      required this.cacheOptions,
      super.key});

  @override
  Widget build(BuildContext context) {
    final preferencesService = PreferencesService(
      preferences,
      secureStorage,
      packageInfo,
    );

    final Dio dio = DioClient.instance(
      preferencesService,
      connectTimeout: const Duration(minutes: 1),
    );
    dio.interceptors.add(DioCacheInterceptor(options: cacheOptions));
    // preferencesService.clear();
    return MultiRepositoryProvider(
      providers: [
        // RepositoryProvider(create: (_) => ServerTimeService(dio)),
        RepositoryProvider(create: (_) => AppCacheManager()),
        RepositoryProvider(create: (_) => preferencesService),
        RepositoryProvider(create: (_) => AuthService(dio)),
        RepositoryProvider(create: (_) => UserService(dio)),
        RepositoryProvider(create: (_) => ProfessionalService(dio)),
        RepositoryProvider(create: (_) => NotificationsService(dio)),
        RepositoryProvider(create: (_) => GeolocationService()),
        RepositoryProvider(create: (_) => ActuService(dio)),
     
        RepositoryProvider(create: (_) => DirectionsService( )),
        RepositoryProvider(create: (_) => NotificationService()),
        RepositoryProvider(
            create: (context) =>
                ProfessionalCubitManager(context.read(), preferencesService)),
        RepositoryProvider(
            create: (context) => ActuCubitManager(context.read())),

        RepositoryProvider(create: (context) => CatalogueCubitManager()),
      ],
      child: MultiBlocProvider(
        providers: [
          // BlocProvider(create: (context) => ServerTimeCubit(context.read())),
          BlocProvider(create: (_) => HomeBottomNavigationCubit()),
          BlocProvider(
            create: (context) => LinkCubit(context.read()),
          ),
          BlocProvider(
              create: (context) => UserCubit(
                    context.read(),
                    preferencesService,
                  )),
          BlocProvider(
              create: (context) =>
                  MyProfessionalCubit(context.read(), preferencesService)),
          BlocProvider(
              create: (context) => GestionProfessionalCubit(
                    context.read(),
                    context.read(),
                  )),
          BlocProvider(
              create: (context) => NewProfessionalCubit(
                    context.read(),
                    context.read(),
                  )),
          BlocProvider(create: (_) => AccountViewManageCubit()),
          BlocProvider(create: (_) => ThemeModeCubit(preferencesService)),
          BlocProvider(
              create: (context) => AuthCubit(context.read(), context.read())),
          BlocProvider(
              create: (context) =>
                  LoadMeCatalogueCubit(context.read(), context.read())),
          BlocProvider(create: (context) => LoadMeAgendaCubit(context.read())),
          BlocProvider(create: (context) => AddScheduleCubit()),
          BlocProvider(
              create: (context) => LoadActuCubit(
                  context.read(), context.read(), context.read())),
          BlocProvider(create: (context) => ScheduleCubit()),
          BlocProvider(create: (context) => SelectRealisationCubit()),
          BlocProvider(
              create: (context) =>
                  ActionProfessionalCubit(context.read(), context.read())),
          BlocProvider(
              create: (context) => LoadMeRendezVousCubit(
                    context.read(),
                  )),
          BlocProvider(
              create: (context) => LoadMeProRendezVousCubit(
                    context.read(),
                  )),
          BlocProvider(
              create: (context) => LoadNotificationsCubit(
                    context.read(),
                  )),
          BlocProvider(
            create: (context) => NotificationCubit(
              preferencesService,
              context.read(),
              context.read(),
              context.read(),
            ),
          ),
              BlocProvider(
              create: (context) =>
                  MapTrackingCubit(context.read(), context.read())),
        
          // BlocProvider(
          //   create: (context) => MySearchCubit(
          //     actuService: context.read(),
          //     proCubitManager: context.read(),
          //     actuCubitManager: context.read(),
          //   ),
          // ),

          BlocProvider(create: (_) => VideoVolumeCubit()),

          BlocProvider(create: (_) => VideoCubit())
        ],
        child: BlocBuilder<ThemeModeCubit, ThemeMode>(
          builder: (context, mode) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'beauty!',
              theme: AppTheme.lightTheme(context),
              darkTheme: AppTheme.darkTheme(context),
              themeMode: mode,
              locale: const Locale.fromSubtags(languageCode: 'fr'),
              supportedLocales: const [Locale.fromSubtags(languageCode: 'fr')],
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              builder: (context, child) => BlocListener<UserCubit, UserState>(
                    listenWhen: (previous, state) {
                      return (previous is UserLoggingOut ||
                              previous is UserDeleting) &&
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
              home: SplashPage()

              //  Builder(builder: (context) {
              //   // return const HomeScreen();
              //   // return const OnboardingScreen();
              //   return BlocBuilder<UserCubit, UserState>(
              //     buildWhen: (previous, _) => previous is InitializingUserState,
              //     builder: (context, state) {
              //       if (state is InitializingUserState) {
              //         return const SizedBox();
              //       }

              //       if (state is UserNotLoggedState) {
              //         return const OnboardingScreen();
              //       }
              //       if (state is CompleteUserProfileState) {
              //         return const CompleteInfoPage();
              //       }
              //       if (state is UserLoggedState) return const HomeScreen();
              //       return const OnboardingScreen();
              //     },
              //   );
              // }),
              ),
        ),
      ),
    );
  }
}
