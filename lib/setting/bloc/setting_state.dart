import 'package:flutter/material.dart';

abstract class SettingState {
  final Locale locale;
  final bool isDark;
  const SettingState(this.locale, this.isDark);
}

class SettingChange extends SettingState {
  const SettingChange(Locale locale, bool isDark) : super(locale, isDark);
}
