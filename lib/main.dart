import 'package:shattably/features/auth/domain/auth_repository.dart';
import 'package:shattably/features/auth/domain/auth_use_cases.dart';
import 'package:shattably/features/auth/presentation/auth_cubits.dart';
import 'package:shattably/core/presentation/load_state.dart';
import 'app/dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/bloc_observer.dart';
import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:shattably/features/home/presention/widgets/login/service_login_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/cubit/cubit.dart';
import 'package:shattably/firebase_options.dart';
import 'package:shattably/home.dart';
import 'package:shattably/navigationservice.dart';
import 'package:shattably/network/local/cache_helper.dart';
import 'package:shattably/network/remote/dio_helper.dart';
import'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shattably/notificationservice.dart';
import 'package:flutter/services.dart';


final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white24, // Set scaffold background color
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white24, // Set app bar background color

  ),
  // Define other theme properties if needed
);

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.grey, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage( NotificationService.onBackgroundMessageHandler);
  await NotificationService.initMessagingServices();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();





  final dependencies = AppDependencies.firebase();
  runApp(RepositoryProvider<AuthRepository>.value(value: dependencies.auth,
    child: BlocProvider(create: (_) => SessionCubit(WatchAuthSession(dependencies.auth), SignOut(dependencies.auth)),
      child: const MyApp())));
}



class MyApp extends StatelessWidget {
  final Locale? locale;

  final Widget? startWidget;
  const MyApp({super.key, 
    this.startWidget, this.locale,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ServiceCubit(),
        ),
        BlocProvider(
          create: (context) => ServiceMenuCubit(),
        ),
      ],
      child: BlocConsumer<ServiceCubit, ServiceLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            title: 'Services',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(ServiceMenuCubit.get(context).value == 1 ? 'ar' : 'en',''),
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: BlocBuilder<SessionCubit, LoadState<AuthUser>>(
              builder: (context, state) {
                if (state.status == LoadStatus.loading) {
                  return const Scaffold(body: Center(child: CircularProgressIndicator()));
                }
                return state.data?.emailVerified == true ? const Home() : const ServiceLoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}

//(Language.languageList().first == 1)? Locale('ar','') :  Locale('en','')