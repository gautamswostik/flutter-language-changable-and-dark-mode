import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lang_and_dark/app_setup/hive/hive_box.dart';
import 'package:lang_and_dark/app_setup/language/entities/language_entity.dart';
import 'package:lang_and_dark/application/language/language_cubit.dart';
import 'package:lang_and_dark/utils/apptexts/app_texts.dart';
import 'package:lang_and_dark/app_setup/language/languages.dart';
import 'package:lang_and_dark/utils/extensions/string_extensions.dart';

class HomeScreen extends StatefulHookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTexts.home.translateTo(context)),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => <PopupMenuEntry>[
              ...Languages.languages
                  .map<PopupMenuEntry>(
                    (e) => PopupMenuItem(
                      child: ListTile(
                        onTap: () async {
                          BlocProvider.of<LanguageCubit>(context).toggle(e);
                          final languageBox =
                              await Hive.openBox(HiveBox.languageBox);
                          await languageBox.put('language', e.languageCode);
                          languageBox.close();
                        },
                        leading: const Icon(Icons.language_sharp),
                        title: Text(e.languageName.translateTo(context)),
                      ),
                    ),
                  )
                  .toList(),
              // const PopupMenuItem(
              //   child: ListTile(
              //     leading: Icon(Icons.add),
              //     title: Text('Item 1'),
              //   ),
              // ),
              // const PopupMenuItem(
              //   child: ListTile(
              //     leading: Icon(Icons.anchor),
              //     title: Text('Item 2'),
              //   ),
              // ),
              // const PopupMenuItem(
              //   child: ListTile(
              //     leading: Icon(Icons.article),
              //     title: Text('Item 3'),
              //   ),
              // ),
              // const PopupMenuDivider(),
              // const PopupMenuItem(child: Text('Item A')),
              // const PopupMenuItem(child: Text('Item B')),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          int num = index + 1;

          if (num % 3 == 0) {
            return Text("Fizz".translateTo(context));
          } else if (num % 5 == 0) {
            return Text("Buzz".translateTo(context));
          } else {
            return Text("$num".translateTo(context));
          }
        },
      ),
    );
  }
}
