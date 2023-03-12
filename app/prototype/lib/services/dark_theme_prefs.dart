

class DarkThemePreferences {
  static var isDarkTheme;

  setDarkTheme (bool value ) async {
    isDarkTheme = value;
  }
  bool getTheme() {
    return isDarkTheme ?? false;
  }
}