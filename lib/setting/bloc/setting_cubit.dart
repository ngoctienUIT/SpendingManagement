import 'dart:io' show Platform;
import 'package:flutter/material.dart' show Locale;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spending_management/setting/bloc/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  int? language;
  bool isDark;

  SettingCubit({this.language, required this.isDark})
      : super(
          SettingChange(
            _getLocal(language),
            isDark,
          ),
        );

  static Locale _getLocal(int? lang) {
    return lang == null
        ? Locale(Platform.localeName.split('_')[0] == "vi" ? "vi" : "en")
        : (lang == 0 ? const Locale('vi') : const Locale('en'));
  }

  void toVietnamese() {
    language = 0;
    emit(SettingChange(const Locale('vi'), isDark));
  }

  void toEnglish() {
    language = 1;
    emit(SettingChange(const Locale('en'), isDark));
  }

  void changeTheme() {
    Locale locale = _getLocal(language);
    isDark = !isDark;
    emit(SettingChange(locale, isDark));
  }
}
