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
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Reminders`
  String get reminders {
    return Intl.message(
      'Reminders',
      name: 'reminders',
      desc: '',
      args: [],
    );
  }

  /// `{date} in {time}`
  String onDateInTime(Object date, Object time) {
    return Intl.message(
      '$date in $time',
      name: 'onDateInTime',
      desc: '',
      args: [date, time],
    );
  }

  /// `EDIT`
  String get editButton {
    return Intl.message(
      'EDIT',
      name: 'editButton',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get titleHint {
    return Intl.message(
      'Title',
      name: 'titleHint',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descriptionHint {
    return Intl.message(
      'Description',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `SAVE`
  String get saveButton {
    return Intl.message(
      'SAVE',
      name: 'saveButton',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get cancelButton {
    return Intl.message(
      'CANCEL',
      name: 'cancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Specify title`
  String get specifyTitle {
    return Intl.message(
      'Specify title',
      name: 'specifyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reminders list is empty`
  String get noRemindersHint {
    return Intl.message(
      'Reminders list is empty',
      name: 'noRemindersHint',
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
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}