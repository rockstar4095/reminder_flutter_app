import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _primary = Color(0xff7e57c2);
final _primaryLight = Color(0xffd1c4e9);
final _secondary = _primary;
final _hint = Color(0xff9575cd);
final _disabled = Color(0xffeeeeee);
final _error = Color(0xffff5722);
final _textColor = Color(0xff3c4444);

final lightTheme = ThemeData.light().copyWith(
  colorScheme: _lightColorScheme,
  primaryColor: _primary,
  primaryColorLight: _primaryLight,
  shadowColor: _primaryLight,
  primaryColorBrightness: Brightness.dark,
  accentColor: _secondary,
  buttonColor: _secondary,
  disabledColor: _disabled,
  hintColor: _hint,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  floatingActionButtonTheme: _lightFabTheme,
  buttonTheme: _lightButtonTheme,
  textTheme: _lightTextTheme,
  appBarTheme: _lightAppBarTheme,
);

final _lightFabTheme = ThemeData.light().floatingActionButtonTheme.copyWith(
      foregroundColor: Colors.white,
    );

final _lightButtonTheme = ThemeData.light().buttonTheme.copyWith(
      buttonColor: _secondary,
      textTheme: ButtonTextTheme.primary,
    );

final _lightColorScheme = ColorScheme.light().copyWith(
  primary: _primary,
  primaryVariant: _primary,
  secondary: _secondary,
  secondaryVariant: _secondary,
  error: _error,
  onSurface: _secondary,
  onBackground: _secondary,
  brightness: Brightness.light,
);

final _lightAppBarTheme = ThemeData.light().appBarTheme.copyWith(
      textTheme: _lightTextTheme.copyWith(
        headline6: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.15,
        ),
      ),
    );

final _lightTextTheme = ThemeData.light().textTheme.copyWith(
      headline3: GoogleFonts.inter(
        color: _textColor,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      headline4: GoogleFonts.inter(
        color: _textColor,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      headline5: GoogleFonts.inter(
        color: _textColor,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      headline6: GoogleFonts.inter(
        color: _textColor,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      subtitle1: GoogleFonts.inter(
        color: _textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitle2: GoogleFonts.inter(
        color: _hint,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: GoogleFonts.inter(
        color: _textColor,
        fontSize: 16,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        height: 1.25,
      ),
      bodyText2: GoogleFonts.inter(
        color: _textColor,
        fontSize: 14,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.25,
      ),
      button: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.normal,
      ),
      caption: GoogleFonts.inter(
        color: _hint,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
      overline: GoogleFonts.inter(
        color: _hint,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
    );
