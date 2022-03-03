import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lang_and_dark/app/app_localization.dart';
import 'package:lang_and_dark/app_setup/language/languages.dart';
import 'package:lang_and_dark/app_setup/theme/theme_choices.dart';
import 'package:lang_and_dark/application/language/language_cubit.dart';
import 'package:lang_and_dark/application/theme/theme_cubit.dart';
import 'package:lang_and_dark/presentation/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends HookWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit()..getLang(),
        ),
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit()..getTheme(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          if (state is LanguageLoaded) {
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                if (themeState is ThemeLoaded) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    home: HomeScreen(
                      themeValue: themeState.isDarkValue,
                    ),
                    theme: themeState.isDark,
                    themeMode: ThemeMode.system,
                    supportedLocales: [
                      ...Languages.languages
                          .map((e) => Locale(e.languageCode))
                          .toList(),
                    ],
                    locale: state.locale,
                    localizationsDelegates: const [
                      AppLocalization.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                  );
                }
                return const SizedBox();
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
