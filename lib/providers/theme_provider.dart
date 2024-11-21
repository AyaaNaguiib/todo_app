import 'package:flutter/material.dart';
import '../core/utils/app_styles.dart';
import '../core/utils/colors_manager.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
  TextStyle get appBarStyle => isDarkMode ? DarkAppStyle.appBar : LightAppStyle.appBar;
  TextStyle get themeLabelStyle => isDarkMode ? DarkAppStyle.themeLabel : LightAppStyle.themeLabel;
  TextStyle get selectedThemeLabelStyle => isDarkMode ? DarkAppStyle.selectedThemeLabel : LightAppStyle.selectedThemeLabel;
  TextStyle get bottomSheetTitleStyle => isDarkMode ? DarkAppStyle.bottomSheetTitle : LightAppStyle.bottomSheetTitle;
  TextStyle get hintStyle => isDarkMode ? DarkAppStyle.hint : LightAppStyle.hint;
  TextStyle get dateStyle => isDarkMode ? DarkAppStyle.date : LightAppStyle.date;
  TextStyle get todoTitleStyle => isDarkMode ? DarkAppStyle.todoTitle : LightAppStyle.todoTitle;
  TextStyle get todoDescriptionStyle => isDarkMode ? DarkAppStyle.todoDiscription : LightAppStyle.todoDiscription;
  Color get backgroundColor => isDarkMode ? ColorsManager.darkBs : Colors.white;
}
