import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lang_and_dark/app_setup/hive/hive_box.dart';
import 'package:lang_and_dark/app_setup/theme/theme_choices.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void toggleTheme(bool isDark) async {
    final themeBox = await Hive.openBox(HiveBox.themeBox);
    await themeBox.put('theme', isDark);
    if (isDark) {
      emit(ThemeLoaded(
        isDark: ThemeChoice.darkMode,
        isDarkValue: isDark,
      ));
    } else {
      emit(ThemeLoaded(
        isDark: ThemeChoice.lightMode,
        isDarkValue: isDark,
      ));
    }
  }

  void getTheme() async {
    bool isDark = await isDarkMode;
    if (isDark) {
      emit(ThemeLoaded(
        isDark: ThemeChoice.darkMode,
        isDarkValue: isDark,
      ));
    } else {
      emit(ThemeLoaded(
        isDark: ThemeChoice.lightMode,
        isDarkValue: isDark,
      ));
    }
  }

  Future<bool> get isDarkMode async {
    final themeBox = await Hive.openBox(HiveBox.themeBox);
    bool theme = themeBox.get('theme', defaultValue: false);
    themeBox.close();
    return theme;
  }
}
