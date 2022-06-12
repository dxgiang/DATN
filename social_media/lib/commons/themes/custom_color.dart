// Referer https://github.com/ant-design/ant-design-colors/blob/95ef010cab5e519685c57b003ab740afbf0434de/src/generate.ts#L78

import 'package:flutter/material.dart';
import 'package:tinycolor2/tinycolor2.dart';

const _hueStep = 2; // 色相阶梯
const _saturationStep = 0.16; // 饱和度阶梯，浅色部分
const _saturationStep2 = 0.05; // 饱和度阶梯，深色部分
const _brightnessStep1 = 0.05; // 亮度阶梯，浅色部分
const _brightnessStep2 = 0.15; // 亮度阶梯，深色部分
const _lightColorCount = 5; // 浅色数量，主色上
const _darkColorCount = 4; // 深色数量，主色下

class _DarkColorMaps {
  int index;
  double opacity;

  _DarkColorMaps(this.index, this.opacity);
}

List<_DarkColorMaps> darkColorMaps = [
  _DarkColorMaps(7, 0.15),
  _DarkColorMaps(6, 0.25),
  _DarkColorMaps(5, 0.3),
  _DarkColorMaps(5, 0.45),
  _DarkColorMaps(5, 0.65),
  _DarkColorMaps(5, 0.85),
  _DarkColorMaps(4, 0.9),
  _DarkColorMaps(3, 0.95),
  _DarkColorMaps(2, 0.97),
  _DarkColorMaps(1, 0.98),
];

Color _mix(Color rgb1, Color rgb2, num amount) {
  final p = amount / 100;
  Color rgb = Color.fromRGBO(
      ((rgb2.red - rgb1.red) * p).round() + rgb1.red,
      ((rgb2.green - rgb1.green) * p).round() + rgb1.green,
      ((rgb2.blue - rgb1.blue) * p).round() + rgb1.blue,
      1);
  return rgb;
}

num _getHue(HSVColor hsv, num i, {bool light = true}) {
  num hue;
  if (hsv.hue.round() >= 60 && hsv.hue.round() <= 240) {
    hue =
        light ? hsv.hue.round() - _hueStep * i : hsv.hue.round() + _hueStep * i;
  } else {
    hue =
        light ? hsv.hue.round() + _hueStep * i : hsv.hue.round() - _hueStep * i;
  }
  if (hue < 0) {
    hue += 360;
  } else if (hue >= 360) {
    hue -= 360;
  }
  return hue;
}

num _getSaturation(HSVColor hsv, num i, {bool light = true}) {
  if (hsv.hue == 0 && hsv.saturation == 0) {
    return hsv.saturation;
  }
  num saturation;
  if (light) {
    saturation = hsv.saturation - _saturationStep * i;
  } else if (i == _darkColorCount) {
    saturation = hsv.saturation + _saturationStep;
  } else {
    saturation = hsv.saturation + _saturationStep2 * i;
  }
  // 边界值修正
  if (saturation > 1) {
    saturation = 1;
  }
  // 第一格的 s 限制在 0.06-0.1 之间
  if (light && i == _lightColorCount && saturation > 0.1) {
    saturation = 0.1;
  }

  if (saturation < 0.06) {
    saturation = 0.06;
  }

  return num.parse(saturation.toStringAsFixed(2));
}

num _getValue(HSVColor hsv, num i, {bool light = true}) {
  num value;
  if (light) {
    value = hsv.value + _brightnessStep1 * i;
  } else {
    value = hsv.value - _brightnessStep2 * i;
  }
  if (value > 1) {
    value = 1;
  }
  return num.parse(value.toStringAsFixed(2));
}

class ColorPalette {
  Color _baseColor;

  late List<Color> _patterns;

  ColorPalette(this._baseColor);

  factory ColorPalette.generate(Color baseColor,
      {bool isDark = false, Color? backgroundColor}) {
    ColorPalette palette = ColorPalette(baseColor);
    palette._generate(isDark, backgroundColor);
    return palette;
  }

  factory ColorPalette.fromList(Color baseColor, List<Color> patterns) {
    ColorPalette palette = ColorPalette(baseColor);
    palette._patterns = patterns;
    return palette;
  }

  Color get o1 => _patterns[0];

  Color get o2 => _patterns[1];

  Color get o3 => _patterns[2];

  Color get o4 => _patterns[3];

  Color get o5 => _patterns[4];

  Color get o6 => _patterns[5];

  Color get o7 => _patterns[6];

  Color get o8 => _patterns[7];

  Color get o9 => _patterns[8];

  Color get o10 => _patterns[9];

  void _generate(bool isDark, Color? backgroundColor) {
    _patterns = [];
    final pColor = TinyColor(_baseColor);
    for (int i = _lightColorCount; i > 0; i--) {
      final hsv = pColor.toHsv();
      Color color = TinyColor.fromHSV(HSVColor.fromAHSV(
        1,
        _getHue(hsv, i, light: true).toDouble(),
        _getSaturation(hsv, i, light: true).toDouble(),
        _getValue(hsv, i, light: true).toDouble(),
      )).color;
      _patterns.add(color);
    }
    _patterns.add(_baseColor);
    for (int i = 1; i <= _darkColorCount; i++) {
      final hsv = pColor.toHsv();
      Color color = TinyColor.fromHSV(HSVColor.fromAHSV(
        1,
        _getHue(hsv, i, light: false).toDouble(),
        _getSaturation(hsv, i, light: false).toDouble(),
        _getValue(hsv, i, light: false).toDouble(),
      )).color;
      _patterns.add(color);
    }
    if (isDark) {
      _patterns = darkColorMaps.map((e) {
        Color dartColor = _mix(backgroundColor ?? const Color(0xFF141414),
            _patterns[e.index], e.opacity * 100);
        return dartColor;
      }).toList();
    }
  }

  @override
  String toString() {
    return _patterns.toString();
  }
}

class PresetColors {
  late ColorPalette red;
  late ColorPalette volcano;
  late ColorPalette orange;
  late ColorPalette gold;
  late ColorPalette yellow;
  late ColorPalette lime;
  late ColorPalette green;
  late ColorPalette cyan;
  late ColorPalette blue;
  late ColorPalette geekBlue;
  late ColorPalette purple;
  late ColorPalette magenta;
  late ColorPalette grey;
  late NeutralColor neutral;

  PresetColors({bool isDark = false, Color? backgroundColor}) {
    red = ColorPalette.generate(const Color(0xFFF5222D),
        isDark: isDark, backgroundColor: backgroundColor);
    volcano = ColorPalette.generate(const Color(0xFFFA541C),
        isDark: isDark, backgroundColor: backgroundColor);
    orange = ColorPalette.generate(const Color(0xFFFA8C16),
        isDark: isDark, backgroundColor: backgroundColor);
    gold = ColorPalette.generate(const Color(0xFFFAAD14),
        isDark: isDark, backgroundColor: backgroundColor);
    yellow = ColorPalette.generate(const Color(0xFFFADB14),
        isDark: isDark, backgroundColor: backgroundColor);
    lime = ColorPalette.generate(const Color(0xFFA0D911),
        isDark: isDark, backgroundColor: backgroundColor);
    green = ColorPalette.generate(const Color(0xFF52C41A),
        isDark: isDark, backgroundColor: backgroundColor);
    cyan = ColorPalette.generate(const Color(0xFF13C2C2),
        isDark: isDark, backgroundColor: backgroundColor);
    blue = ColorPalette.generate(const Color(0xFF1890FF),
        isDark: isDark, backgroundColor: backgroundColor);
    geekBlue = ColorPalette.generate(const Color(0xFF2F54EB),
        isDark: isDark, backgroundColor: backgroundColor);
    purple = ColorPalette.generate(const Color(0xFF722ED1),
        isDark: isDark, backgroundColor: backgroundColor);
    magenta = ColorPalette.generate(const Color(0xFFEB2F96),
        isDark: isDark, backgroundColor: backgroundColor);

    List<Color> _greyColors = [
      const Color(0xFFFFFFFF),
      const Color(0xFFFAFAFA),
      const Color(0xFFF5F5F5),
      const Color(0xFFF0F0F0),
      const Color(0xFFD9D9D9),
      const Color(0xFFBFBFBF),
      const Color(0xFF8C8C8C),
      const Color(0xFF595959),
      const Color(0xFF262626),
      const Color(0xFF000000),
    ];
    if (isDark) {
      _greyColors = _greyColors.reversed.toList();
    }
    grey = ColorPalette.fromList(const Color(0xFFbfbfbf), _greyColors);
    neutral = NeutralColor(
        isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000));
  }

  Color get success => green.o6;

  Color get link => blue.o6;

  Color get warning => gold.o6;

  Color get error => red.o5;
}

class NeutralColor {
  late Color title;
  late Color primary;
  late Color secondary;
  late Color disable;
  late Color border;
  late Color divider;
  late Color background;
  late Color header;

  NeutralColor(Color baseColor) {
    title = baseColor.withOpacity(.85);
    primary = baseColor.withOpacity(.85);
    secondary = baseColor.withOpacity(.45);
    disable = baseColor.withOpacity(.25);
    border = baseColor.withOpacity(.15);
    divider = baseColor.withOpacity(.6);
    background = baseColor.withOpacity(.4);
    header = baseColor.withOpacity(.2);
  }
}
