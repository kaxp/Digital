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

  /// `Home Page`
  String get homePage {
    return Intl.message(
      'Home Page',
      name: 'homePage',
      desc: '',
      args: [],
    );
  }

  /// `Navigate to Detail Page`
  String get navigateToDetailPage {
    return Intl.message(
      'Navigate to Detail Page',
      name: 'navigateToDetailPage',
      desc: '',
      args: [],
    );
  }

  /// `Detail Page`
  String get detailPage {
    return Intl.message(
      'Detail Page',
      name: 'detailPage',
      desc: '',
      args: [],
    );
  }

  /// `Back to Home`
  String get backToHome {
    return Intl.message(
      'Back to Home',
      name: 'backToHome',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while connecting to the server. Please try again`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong while connecting to the server. Please try again',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Make sure you are connected to an internet connection and please try again.`
  String get networkErrorMessage {
    return Intl.message(
      'Make sure you are connected to an internet connection and please try again.',
      name: 'networkErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `Request cancelled`
  String get networkRequestCanceled {
    return Intl.message(
      'Request cancelled',
      name: 'networkRequestCanceled',
      desc: '',
      args: [],
    );
  }

  /// `Client Id is invalid, please check and try again`
  String get invalidClientIdError {
    return Intl.message(
      'Client Id is invalid, please check and try again',
      name: 'invalidClientIdError',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, something went wrong`
  String get unknownError {
    return Intl.message(
      'Sorry, something went wrong',
      name: 'unknownError',
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
