import 'package:gameshare/services/theme_prefs.dart';

class ThemeProvider {
  static final ThemePreferences themePreferences = ThemePreferences();

  get themePrefs => themePreferences;

  addListener(listener) {
    themePreferences.addListener(listener);
  }

  removeListener(listener) {
    themePreferences.removeListener(listener);
  }

  get themeMode => themePreferences.themeMode;

  isDarkMode() => themePreferences.getTheme();

  toggleTheme() => themePreferences.setTheme(!themePreferences.getTheme());
}
