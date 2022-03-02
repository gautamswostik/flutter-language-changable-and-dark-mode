import 'package:lang_and_dark/app_setup/language/entities/language_entity.dart';

class Languages {
  const Languages();

  static const languages = [
    LanguageEntity(languageCode: 'en', languageName: 'English'),
    LanguageEntity(languageCode: 'es', languageName: 'Spanish'),
    LanguageEntity(languageCode: 'ne', languageName: 'Nepali'),
    LanguageEntity(languageCode: 'ko', languageName: 'Korean'),
  ];
}
