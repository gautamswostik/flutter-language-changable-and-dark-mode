import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lang_and_dark/app_setup/hive/hive_box.dart';
import 'package:lang_and_dark/app_setup/language/entities/language_entity.dart';
import 'package:lang_and_dark/app_setup/language/languages.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit()
      : super(LanguageLoaded(
          locale: Locale(
            Languages.languages[0].languageCode,
          ),
        ));

  void toggle(LanguageEntity languageEntity) async {
    final languageBox = await Hive.openBox(HiveBox.languageBox);
    await languageBox.put('language', languageEntity.languageCode);
    languageBox.close();
    emit(
      LanguageLoaded(
        locale: Locale(
          languageEntity.languageCode,
        ),
      ),
    );
  }

  void getLang() async {
    String entity = await lang;
    emit(
      LanguageLoaded(
        locale: Locale(
          entity,
        ),
      ),
    );
  }

  Future<String> get lang async {
    final languageBox = await Hive.openBox(HiveBox.languageBox);
    String entity = languageBox.get('language');
    languageBox.close();
    return entity;
  }
}
