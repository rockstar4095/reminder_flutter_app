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

  /// `Напоминания`
  String get reminders {
    return Intl.message(
      'Напоминания',
      name: 'reminders',
      desc: '',
      args: [],
    );
  }

  /// `{date} в {time}`
  String onDateInTime(Object date, Object time) {
    return Intl.message(
      '$date в $time',
      name: 'onDateInTime',
      desc: '',
      args: [date, time],
    );
  }

  /// `ИЗМЕНИТЬ`
  String get editButton {
    return Intl.message(
      'ИЗМЕНИТЬ',
      name: 'editButton',
      desc: '',
      args: [],
    );
  }

  /// `Название`
  String get titleHint {
    return Intl.message(
      'Название',
      name: 'titleHint',
      desc: '',
      args: [],
    );
  }

  /// `Описание`
  String get descriptionHint {
    return Intl.message(
      'Описание',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `СОХРАНИТЬ`
  String get saveButton {
    return Intl.message(
      'СОХРАНИТЬ',
      name: 'saveButton',
      desc: '',
      args: [],
    );
  }

  /// `ОТМЕНА`
  String get cancelButton {
    return Intl.message(
      'ОТМЕНА',
      name: 'cancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Укажите название`
  String get specifyTitle {
    return Intl.message(
      'Укажите название',
      name: 'specifyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Список напоминаний пуст`
  String get noRemindersHint {
    return Intl.message(
      'Список напоминаний пуст',
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