import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/commons/themes/custom_color.dart';
import 'package:social_media/commons/themes/custom_text_theme.dart';

AppBarTheme _appBarTheme(PresetColors colors, TextTheme textTheme,
    {AppBarTheme? baseTheme}) {
  baseTheme ??= const AppBarTheme();
  return baseTheme.copyWith(
    backgroundColor: colors.grey.o1,
    iconTheme: IconThemeData(size: 28.r, color: colors.neutral.title),
    elevation: 0,
    centerTitle: true,
    titleTextStyle: textTheme.bodyText1?.copyWith(
      color: colors.neutral.title,
      fontWeight: FontWeight.w500,
    ),
    actionsIconTheme: IconThemeData(size: 28.r, color: colors.neutral.title),
  );
}

InputDecorationTheme _inputDecorationTheme(
    PresetColors colors, TextTheme textTheme,
    {InputDecorationTheme? baseTheme}) {
  baseTheme ??= const InputDecorationTheme();
  BorderSide borderSide = BorderSide(
    width: 1,
    style: BorderStyle.solid,
    color: colors.neutral.border,
  );
  InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r), borderSide: borderSide);
  return baseTheme.copyWith(
    hintStyle: textTheme.bodyText2
        ?.copyWith(color: colors.neutral.disable, height: 1.4),
    labelStyle:
        textTheme.subtitle1?.copyWith(color: colors.grey.o8, height: 1.2),
    errorStyle: textTheme.subtitle1!.copyWith(color: colors.error),
    fillColor: colors.grey.o1,
    filled: true,
    focusedBorder: border.copyWith(
      borderSide: borderSide.copyWith(color: colors.blue.o5),
    ),
    disabledBorder: border,
    enabledBorder: border,
    border: border,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
  );
}

BottomNavigationBarThemeData _bottomAppBarTheme(
    PresetColors colors, TextTheme textTheme,
    {BottomNavigationBarThemeData? baseTheme}) {
  baseTheme ??= const BottomNavigationBarThemeData();
  Color activeColor = colors.blue.o6;
  Color unActiveColor = colors.neutral.disable;
  return baseTheme.copyWith(
    elevation: 10,
    backgroundColor: colors.grey.o1,
    selectedItemColor: activeColor,
    unselectedItemColor: unActiveColor,
    selectedLabelStyle: textTheme.caption?.copyWith(color: activeColor),
    unselectedLabelStyle: textTheme.caption?.copyWith(color: unActiveColor),
    showSelectedLabels: true,
    type: BottomNavigationBarType.fixed,
    showUnselectedLabels: true,
  );
}

ButtonStyle _elevatedButtonStyle(PresetColors colors, TextTheme textTheme) {
  return ElevatedButton.styleFrom(
          textStyle: textTheme.button, minimumSize: Size(double.infinity, 40.h))
      .copyWith(
    shape: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return RoundedRectangleBorder(
          side: BorderSide(
            width: 1,
            color: colors.grey.o5,
          ),
        );
      }
    }),
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      Color color = colors.blue.o6;
      if (states.contains(MaterialState.disabled)) {
        color = colors.neutral.disable;
      }
      return color;
    }),
  );
}

ButtonStyle _outlinedButtonStyle(PresetColors colors, TextTheme textTheme) {
  return OutlinedButton.styleFrom(
          primary: colors.neutral.title,
          textStyle: textTheme.button,
          minimumSize: Size(double.infinity, 40.h))
      .copyWith(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      Color color = colors.grey.o1;
      if (states.contains(MaterialState.disabled)) {
        color = colors.neutral.disable;
      }
      return color;
    }),
    side: MaterialStateProperty.resolveWith((states) {
      Color color = colors.grey.o5;
      if (states.contains(MaterialState.error)) {
        color = colors.error;
      }
      return BorderSide(width: 1, color: color);
    }),
  );
}

ButtonStyle _textButtonStyle(PresetColors colors, TextTheme textTheme) {
  return TextButton.styleFrom(
    primary: colors.blue.o6,
    textStyle: textTheme.subtitle1?.copyWith(
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
    ),
  );
}

PopupMenuThemeData _popupMenuThemeData(
    PresetColors colors, TextTheme textTheme) {
  return PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      color: colors.grey.o1,
      textStyle: textTheme.subtitle2);
}

ThemeData getThemeData(bool isDark, PresetColors colors) {
  final baseTheme = isDark ? ThemeData.dark() : ThemeData.light();
  TextTheme textTheme = getTextTheme(baseTheme.textTheme);
  return baseTheme.copyWith(
      textTheme: textTheme,
      primaryColor: colors.blue.o6,
      backgroundColor: colors.grey.o1,
      scaffoldBackgroundColor: colors.grey.o1,
      disabledColor: colors.grey.o6,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      cardColor: const Color(0xFF1A7DD8),
      dividerColor: colors.grey.o4,
      hintColor: const Color(0xFF4998E8),
      canvasColor: Colors.transparent,
      iconTheme: IconThemeData(color: colors.blue.o6, size: 18.r),
      errorColor: colors.error,
      bottomNavigationBarTheme: _bottomAppBarTheme(
        colors,
        textTheme,
        baseTheme: baseTheme.bottomNavigationBarTheme,
      ),
      inputDecorationTheme: _inputDecorationTheme(
        colors,
        textTheme,
        baseTheme: baseTheme.inputDecorationTheme,
      ),
      appBarTheme: _appBarTheme(
        colors,
        textTheme,
        baseTheme: baseTheme.appBarTheme,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: _elevatedButtonStyle(colors, textTheme),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: _outlinedButtonStyle(colors, textTheme),
      ),
      textButtonTheme:
          TextButtonThemeData(style: _textButtonStyle(colors, textTheme)),
      popupMenuTheme: _popupMenuThemeData(colors, textTheme));
}
