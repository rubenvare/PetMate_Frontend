import 'package:locale_emoji_flutter/locale_emoji_flutter.dart';

class Language {
  final int id;
  final String flag;
  final String languageCode;

  Language(this.id, this.flag, this.languageCode);

  static List<Language> languagelist() {
    return <Language>[
      Language(1,"","es"),
      Language(2,"", "en")
    ];
  }
}