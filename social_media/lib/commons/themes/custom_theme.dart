import 'package:flutter/material.dart';
import 'package:social_media/commons/themes/custom_color.dart';
import 'package:social_media/commons/themes/custom_theme_data.dart';

class CustomTheme {
  static ThemeData get dark => getThemeData(true, _presetDarkColors);

  static ThemeData get light => getThemeData(false, _presetColors);

  static PresetColors colors(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? _presetDarkColors
        : _presetColors;
  }

  static final PresetColors _presetColors = PresetColors(isDark: false);
  static final PresetColors _presetDarkColors =
      PresetColors(isDark: true, backgroundColor: const Color(0xFF141414));

  late ThemeMode mode;
}
