import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shattably/bloc_observer.dart';
import 'package:shattably/core/utils/constants.dart';
import 'package:shattably/core/utils/styles.dart';
import 'package:shattably/features/home/presention/layout/cubit/cubit.dart';
import 'package:shattably/features/home/presention/layout/cubit/states.dart';
import 'package:shattably/features/home/presention/layout/service_layout_screen.dart';
import 'package:shattably/features/home/presention/widgets/login/service_login_screen.dart';
import 'package:shattably/features/home/presention/widgets/main/widgets/google_maps/google_maps_screen.dart';
import 'package:shattably/features/home/presention/widgets/menu/cubit/cubit.dart';
import 'package:shattably/features/home/presention/widgets/onboarding/onboarding_screen.dart';
import 'package:shattably/features/home/presention/widgets/register/service_register_screen.dart';
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
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white24, // Set app bar background color

  ),
  // Define other theme properties if needed
);

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
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
  Widget widget;

  uId = CacheHelper.getData(key: 'uId');



  runApp(MyApp(

  ));
}



class MyApp extends StatelessWidget {
  final Locale? locale;

  final Widget? startWidget;
  MyApp({
    this.startWidget, this.locale,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ServiceCubit()..getUserData(),
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
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {

                  CacheHelper.saveData(key: 'uId', value: FirebaseAuth.instance.currentUser!.uid);
                  FirebaseFirestore.instance
                      .collection('profiles')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get()
                      .then((docc) {
                    List fcms = docc.get('fcm') ?? [];
                    FirebaseMessaging.instance.getToken().then((myToken) {
                      if (!fcms.contains(myToken!)) {
                        fcms.add(myToken);
                        FirebaseFirestore.instance
                            .collection('profiles')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({'fcm': fcms});
                      }
                    });
                  });
                  return (FirebaseAuth.instance.currentUser!=null && FirebaseAuth.instance.currentUser!.emailVerified)? Home():ServiceLoginScreen();
                }

                return ServiceLoginScreen();
              },
            ),
          );
        },
      ),
    );
  }
}

//(Language.languageList().first == 1)? Locale('ar','') :  Locale('en','')
