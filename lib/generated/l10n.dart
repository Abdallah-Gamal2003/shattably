// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `languages`
  String get languages {
    return Intl.message(
      'languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `about app`
  String get aboutApp {
    return Intl.message(
      'about app',
      name: 'aboutApp',
      desc: '',
      args: [],
    );
  }

  /// `terms and conditions`
  String get termsAndConditions {
    return Intl.message(
      'terms and conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `share`
  String get share {
    return Intl.message(
      'share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get order {
    return Intl.message(
      'Orders',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menuAppBar {
    return Intl.message(
      'Menu',
      name: 'menuAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileAppBar {
    return Intl.message(
      'Profile',
      name: 'profileAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameProfile {
    return Intl.message(
      'Name',
      name: 'nameProfile',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emilProfile {
    return Intl.message(
      'Email Address',
      name: 'emilProfile',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phoneProfile {
    return Intl.message(
      'Phone',
      name: 'phoneProfile',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get updateProfile {
    return Intl.message(
      'Update',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logoutProfile {
    return Intl.message(
      'Logout',
      name: 'logoutProfile',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orderAppBar {
    return Intl.message(
      'Orders',
      name: 'orderAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Electrician`
  String get electricianOrder {
    return Intl.message(
      'Electrician',
      name: 'electricianOrder',
      desc: '',
      args: [],
    );
  }

  /// `Services`
  String get serviceAppBar {
    return Intl.message(
      'Services',
      name: 'serviceAppBar',
      desc: '',
      args: [],
    );
  }

  /// `Electrician`
  String get electrician {
    return Intl.message(
      'Electrician',
      name: 'electrician',
      desc: '',
      args: [],
    );
  }

  /// `Plumber`
  String get plumber {
    return Intl.message(
      'Plumber',
      name: 'plumber',
      desc: '',
      args: [],
    );
  }

  /// `Carpenter`
  String get carpenter {
    return Intl.message(
      'Carpenter',
      name: 'carpenter',
      desc: '',
      args: [],
    );
  }

  /// `Painter`
  String get painter {
    return Intl.message(
      'Painter',
      name: 'painter',
      desc: '',
      args: [],
    );
  }

  /// `Ceramic tiles`
  String get ceramicTiles {
    return Intl.message(
      'Ceramic tiles',
      name: 'ceramicTiles',
      desc: '',
      args: [],
    );
  }

  /// `Smith`
  String get smith {
    return Intl.message(
      'Smith',
      name: 'smith',
      desc: '',
      args: [],
    );
  }

  /// `Conditioning`
  String get conditioning {
    return Intl.message(
      'Conditioning',
      name: 'conditioning',
      desc: '',
      args: [],
    );
  }

  /// `Parquet`
  String get parquet {
    return Intl.message(
      'Parquet',
      name: 'parquet',
      desc: '',
      args: [],
    );
  }

  /// `Portal`
  String get portal {
    return Intl.message(
      'Portal',
      name: 'portal',
      desc: '',
      args: [],
    );
  }

  /// `Marble`
  String get marble {
    return Intl.message(
      'Marble',
      name: 'marble',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Login now to start the service`
  String get loginNowToStart {
    return Intl.message(
      'Login now to start the service',
      name: 'loginNowToStart',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddressLogin {
    return Intl.message(
      'Email Address',
      name: 'emailAddressLogin',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordLogin {
    return Intl.message(
      'Password',
      name: 'passwordLogin',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonLogin {
    return Intl.message(
      'Login',
      name: 'loginButtonLogin',
      desc: '',
      args: [],
    );
  }

  /// `don\t have an account`
  String get dontHaveAnAccoutn {
    return Intl.message(
      'don\t have an account',
      name: 'dontHaveAnAccoutn',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerLogin {
    return Intl.message(
      'Register',
      name: 'registerLogin',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editProfile {
    return Intl.message(
      'Edit',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
