import 'package:shattably/features/home/presentation/widgets/menu/cubit/states.dart';
import 'package:shattably/features/profile/domain/profile_repository.dart';
import 'package:shattably/features/offers/domain/offers_repository.dart';
import 'package:shattably/features/orders/domain/orders_repository.dart';
import 'package:shattably/features/orders/domain/orders_use_cases.dart';
import 'package:shattably/features/orders/presentation/orders_cubits.dart';
import 'package:shattably/features/profile/domain/profile_use_cases.dart';
import 'package:shattably/features/profile/presentation/profile_cubits.dart';
import 'package:shattably/features/auth/domain/auth_repository.dart';
import 'package:shattably/features/auth/domain/auth_use_cases.dart';
import 'package:shattably/features/auth/presentation/auth_cubits.dart';
import 'package:shattably/app/dependencies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shattably/bloc_observer.dart';
import 'package:shattably/features/home/presentation/layout/shell_cubit.dart';
import 'package:shattably/features/home/presentation/widgets/menu/cubit/cubit.dart';
import 'package:shattably/firebase_options.dart';
import 'package:shattably/app/session_gate.dart';
import 'package:shattably/navigationservice.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.grey, // status bar color
  ));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(
      NotificationService.onBackgroundMessageHandler);
  try {
    await NotificationService.initMessagingServices();
  } catch (_) {
    debugPrint('Notifications unavailable on this device.');
  }

  Bloc.observer = MyBlocObserver();

  final dependencies = AppDependencies.firebase();
  runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>.value(value: dependencies.auth),
        RepositoryProvider<ProfileRepository>.value(
            value: dependencies.profiles),
        RepositoryProvider<OrdersRepository>.value(value: dependencies.orders),
        RepositoryProvider<OffersRepository>.value(value: dependencies.offers),
      ],
      child: BlocProvider(
          create: (_) => SessionCubit(
              WatchAuthSession(dependencies.auth), SignOut(dependencies.auth)),
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  final Locale? locale;

  final Widget? startWidget;
  const MyApp({
    super.key,
    this.startWidget,
    this.locale,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => CustomerOrdersCubit(
                GetCustomerOrders(context.read<OrdersRepository>()))),
        BlocProvider(
            create: (context) =>
                ProfileCubit(GetMyProfile(context.read<ProfileRepository>()))),
        BlocProvider(
          create: (BuildContext context) => ShellCubit(),
        ),
        BlocProvider(
          create: (context) => ServiceMenuCubit(),
        ),
      ],
      child: BlocBuilder<ServiceMenuCubit, ServiceMenuStates>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: NavigationService.navigatorKey,
            title: 'Services',
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(
                context.read<ServiceMenuCubit>().value == 1 ? 'ar' : 'en', ''),
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: const SessionGate(),
          );
        },
      ),
    );
  }
}

//(Language.languageList().first == 1)? Locale('ar','') :  Locale('en','')