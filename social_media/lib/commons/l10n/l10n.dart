import 'package:flutter/material.dart';
import 'package:social_media/commons/l10n/generated/l10n.dart';

class L10nTranslation {
  late Locale _locale;

  Locale get locale => _locale;

  List<Locale> supportedLocales;

  L10nTranslation(this.supportedLocales);

  set locale(Locale locale) {
    assert(S.delegate.isSupported(locale));
    _locale = locale;
  }
}
