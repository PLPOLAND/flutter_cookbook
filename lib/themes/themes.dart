import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemesMenager with ChangeNotifier {
  String _theme = "green";
  ThemeMode _themeMode = ThemeMode.system;

  // static final ThemesMenager _instance = ThemesMenager.internal();
  // ThemesMenager.internal();

  // factory ThemesMenager() {
  //   return _instance;
  // }

  void addDynamic(ColorScheme? light, ColorScheme? dark) {
    if (light != null && dark != null) {
      if (!colorShemes.containsKey("dynamic_light") ||
          !colorShemes.containsKey("dynamic_dark")) {
        print("adding dynamic themes");
        colorShemes.addAll({
          'dynamic_light': light,
          'dynamic_dark': dark,
        });
        setTheme("dynamic");
        setThemeMode(ThemeMode.system);
      }
    } else {
      print("dynamic themes are null");
    }
  }

  void setTheme(String theme) {
    // if (theme == "dynamic") {
    //   if (themeMode == ThemeMode.light) {
    //     ThemesMenager.theme = "dynamic_light";
    //     print("setting theme to dynamic light");
    //   } else if (themeMode == ThemeMode.dark) {
    //     ThemesMenager.theme = "dynamic_dark";
    //     print("setting theme to dynamic dark");
    //   }
    // }
    if (ThemesMenager.colorShemes.containsKey("${theme}_light")) {
      _theme = theme;

      print("setting theme to $theme");
      notifyListeners();
    }
  }

  void setThemeMode(ThemeMode themeMode) {
    // print("setting theme mode to $themeMode");
    _themeMode = themeMode;
    notifyListeners();
  }

  ThemeMode get themeMode => _themeMode;

  static Map<String, ColorScheme> colorShemes = {
    'pink_light': const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFB90063),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFD9E2),
      onPrimaryContainer: Color(0xFF3E001D),
      secondary: Color(0xFF396A00),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF9EFA46),
      onSecondaryContainer: Color(0xFF0D2000),
      tertiary: Color(0xFF006E2B),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF69FF89),
      onTertiaryContainer: Color(0xFF002108),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFFFFBFF),
      onBackground: Color(0xFF380036),
      surface: Color(0xFFFFFBFF),
      onSurface: Color(0xFF380036),
      surfaceVariant: Color(0xFFF2DDE1),
      onSurfaceVariant: Color(0xFF514347),
      outline: Color(0xFF837377),
      onInverseSurface: Color(0xFFFFEBF7),
      inverseSurface: Color(0xFF551251),
      inversePrimary: Color(0xFFFFB1C8),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFFB90063),
      outlineVariant: Color(0xFFD5C2C6),
      scrim: Color(0xFF000000),
    ),
    'pink_dark': const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFB1C8),
      onPrimary: Color(0xFF650033),
      primaryContainer: Color(0xFF8E004A),
      onPrimaryContainer: Color(0xFFFFD9E2),
      secondary: Color(0xFF84DD28),
      onSecondary: Color(0xFF1B3700),
      secondaryContainer: Color(0xFF2A5000),
      onSecondaryContainer: Color(0xFF9EFA46),
      tertiary: Color(0xFF48E270),
      onTertiary: Color(0xFF003913),
      tertiaryContainer: Color(0xFF00531F),
      onTertiaryContainer: Color(0xFF69FF89),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
      onError: Color(0xFF690005),
      onErrorContainer: Color(0xFFFFDAD6),
      background: Color(0xFF380036),
      onBackground: Color(0xFFFFD7F4),
      surface: Color(0xFF380036),
      onSurface: Color(0xFFFFD7F4),
      surfaceVariant: Color(0xFF514347),
      onSurfaceVariant: Color(0xFFD5C2C6),
      outline: Color(0xFF9E8C90),
      onInverseSurface: Color(0xFF380036),
      inverseSurface: Color(0xFFFFD7F4),
      inversePrimary: Color(0xFFB90063),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFFFFB1C8),
      outlineVariant: Color(0xFF514347),
      scrim: Color(0xFF000000),
    ),
    'blue_light': const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF00687A),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFABEDFF),
      onPrimaryContainer: Color(0xFF001F26),
      secondary: Color(0xFF4B6269),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFCEE7EF),
      onSecondaryContainer: Color(0xFF061F24),
      tertiary: Color(0xFF565D7E),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFDDE1FF),
      onTertiaryContainer: Color(0xFF131937),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFFEFBFF),
      onBackground: Color(0xFF001849),
      surface: Color(0xFFFEFBFF),
      onSurface: Color(0xFF001849),
      surfaceVariant: Color(0xFFDBE4E7),
      onSurfaceVariant: Color(0xFF3F484B),
      outline: Color(0xFF70797B),
      onInverseSurface: Color(0xFFEEF0FF),
      inverseSurface: Color(0xFF002B75),
      inversePrimary: Color(0xFF55D6F4),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF00687A),
      outlineVariant: Color(0xFFBFC8CB),
      scrim: Color(0xFF000000),
    ),
    'blue_dark': const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF55D6F4),
      onPrimary: Color(0xFF003640),
      primaryContainer: Color(0xFF004E5C),
      onPrimaryContainer: Color(0xFFABEDFF),
      secondary: Color(0xFFB2CBD2),
      onSecondary: Color(0xFF1D343A),
      secondaryContainer: Color(0xFF334A51),
      onSecondaryContainer: Color(0xFFCEE7EF),
      tertiary: Color(0xFFBFC4EB),
      onTertiary: Color(0xFF282F4D),
      tertiaryContainer: Color(0xFF3F4565),
      onTertiaryContainer: Color(0xFFDDE1FF),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
      onError: Color(0xFF690005),
      onErrorContainer: Color(0xFFFFDAD6),
      background: Color(0xFF001849),
      onBackground: Color(0xFFDBE1FF),
      surface: Color(0xFF001849),
      onSurface: Color(0xFFDBE1FF),
      surfaceVariant: Color(0xFF3F484B),
      onSurfaceVariant: Color(0xFFBFC8CB),
      outline: Color(0xFF899295),
      onInverseSurface: Color(0xFF001849),
      inverseSurface: Color(0xFFDBE1FF),
      inversePrimary: Color(0xFF00687A),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF55D6F4),
      outlineVariant: Color(0xFF3F484B),
      scrim: Color(0xFF000000),
    ),
    'green_light': const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF3A6A00),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFB4F575),
      onPrimaryContainer: Color(0xFF0E2000),
      secondary: Color(0xFF57624A),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFDBE7C9),
      onSecondaryContainer: Color(0xFF151E0C),
      tertiary: Color(0xFF386664),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFBBECE9),
      onTertiaryContainer: Color(0xFF00201F),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFF7FFEE),
      onBackground: Color(0xFF002200),
      surface: Color(0xFFF7FFEE),
      onSurface: Color(0xFF002200),
      surfaceVariant: Color(0xFFE0E4D5),
      onSurfaceVariant: Color(0xFF44483E),
      outline: Color(0xFF74796C),
      onInverseSurface: Color(0xFFCAFFB9),
      inverseSurface: Color(0xFF003A01),
      inversePrimary: Color(0xFF99D85C),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF3A6A00),
      outlineVariant: Color(0xFFC4C8BA),
      scrim: Color(0xFF000000),
    ),
    'green_dark': const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF99D85C),
      onPrimary: Color(0xFF1B3700),
      primaryContainer: Color(0xFF2A5000),
      onPrimaryContainer: Color(0xFFB4F575),
      secondary: Color(0xFFBFCBAE),
      onSecondary: Color(0xFF29341F),
      secondaryContainer: Color(0xFF3F4A34),
      onSecondaryContainer: Color(0xFFDBE7C9),
      tertiary: Color(0xFFA0CFCD),
      onTertiary: Color(0xFF003736),
      tertiaryContainer: Color(0xFF1E4E4C),
      onTertiaryContainer: Color(0xFFBBECE9),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
      onError: Color(0xFF690005),
      onErrorContainer: Color(0xFFFFDAD6),
      background: Color(0xFF002200),
      onBackground: Color(0xFFB0F49E),
      surface: Color(0xFF002200),
      onSurface: Color(0xFFB0F49E),
      surfaceVariant: Color(0xFF44483E),
      onSurfaceVariant: Color(0xFFC4C8BA),
      outline: Color(0xFF8E9285),
      onInverseSurface: Color(0xFF002200),
      inverseSurface: Color(0xFFB0F49E),
      inversePrimary: Color(0xFF3A6A00),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF99D85C),
      outlineVariant: Color(0xFF44483E),
      scrim: Color(0xFF000000),
    ),
  };

  ColorScheme? getColorScheme({bool systemAutoBrightness = false}) {
    if (systemAutoBrightness == false || _themeMode != ThemeMode.system) {
      if (_themeMode == ThemeMode.light) {
        if (colorShemes.containsKey("${_theme}_light")) {
          return colorShemes["${_theme}_light"];
        } else {
          return colorShemes["pink_light"];
        }
      } else if (_themeMode == ThemeMode.dark) {
        if (colorShemes.containsKey("${_theme}_dark")) {
          return colorShemes["${_theme}_dark"];
        } else {
          return colorShemes["pink_dark"];
        }
      } else {
        return colorShemes["pink_light"];
      }
    } else {
      print(
          "themeMode: ${SchedulerBinding.instance.platformDispatcher.platformBrightness}");
      if (SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.dark) {
        if (colorShemes.containsKey("${_theme}_dark")) {
          return colorShemes["${_theme}_dark"];
        } else {
          return colorShemes["pink_dark"];
        }
      } else if (SchedulerBinding
              .instance.platformDispatcher.platformBrightness ==
          Brightness.light) {
        if (colorShemes.containsKey("${_theme}_light")) {
          return colorShemes["${_theme}_light"];
        } else {
          return colorShemes["pink_light"];
        }
      } else {
        return colorShemes["pink_light"];
      }
    }
  }
}
