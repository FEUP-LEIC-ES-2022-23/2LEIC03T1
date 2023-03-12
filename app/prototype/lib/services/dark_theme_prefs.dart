
class DarkThemePreferences {
  static var callback;
  setCallback(Function c){
    callback=c;
  }
  static var isDarkTheme;

  setDarkTheme (bool value ) async {
    isDarkTheme = value;
    if(callback!=null)callback();
  }
  bool getTheme() {
    return isDarkTheme ?? false;
  }
}