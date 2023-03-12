class DarkThemePreferences {
  static Function? callback;
  static bool? isDarkTheme;

  setCallback(Function c) {
    callback = c;
  }

  setDarkTheme(bool value) async {
    isDarkTheme = value;
    callback!();
  }

  bool getTheme() {
    return isDarkTheme ?? false;
  }
}
