import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:core/app/locale/cubit/locale_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const englishLocale = Locale("en");
const arabicLocale = Locale("ar");

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleState.initial());
  final List<Locale> supportedLocales = List.from(
    [
      englishLocale,
      arabicLocale,
    ],
    growable: false,
  );

  Future<Locale> getCurrentDeviceLocale() async {
    Locale? locale;
    final currentDeviceLocale = Platform.localeName.split("_").first;
    if (_isCurrentDeviceLocaleSupported(currentDeviceLocale)) {
      locale = Locale(currentDeviceLocale);
    } else {
      locale = englishLocale;
    }
    emit(const LocaleState.changeState());
    return locale;
  }

  void changeLocale(Locale lc, BuildContext context) {
    emit(const LocaleState.loading());
    EasyLocalization.of(context)?.setLocale(lc);
    emit(LocaleState.changed(locale: lc));
  }

  bool _isCurrentDeviceLocaleSupported(String name) {
    if (name == "en" || name == "ar") {
      return true;
    }
    return false;
  }
}
