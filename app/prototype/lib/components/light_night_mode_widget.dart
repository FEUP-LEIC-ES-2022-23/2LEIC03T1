import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prototype/services/dark_theme_prefs.dart';
import 'package:provider/provider.dart';

class LightNightModeWidget extends StatelessWidget {
  const LightNightModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SafeArea(
        child: Align(
            alignment: Alignment.topRight,
            child: TextButton(
                child: Icon(
                  DarkThemePreferences().getTheme()
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  DarkThemePreferences()
                      .setDarkTheme(!DarkThemePreferences().getTheme());
                })),
      ),
    );
  }
}
