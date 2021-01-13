import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tamu_chat/screens/HomeScreen.dart';
import 'package:tamu_chat/screens/LoginScreen.dart';
import 'package:tamu_chat/utilities/GlobalVariables.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  currentUsername = prefs.getString('username');
  currentUserPhoneNumber = prefs.getString('phonenumber');

  database = openDatabase(
    join(await getDatabasesPath(), 'tamu_chat.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE messages(withUsername TEXT, body TEXT, fromUser INTEGER)",
      );
    },
    version: 1,
  );

  runApp(
    EasyLocalization(
        supportedLocales: [
          Locale('en', 'UK'),
          Locale('tr', 'TUR'),
        ],
        path: 'asset/locales',
        fallbackLocale: Locale(
            selectedLanguagePack.countryCode, selectedLanguagePack.localeCode),
        child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (currentUserPhoneNumber == null) {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'FontsFree-Net-SFProDisplay'),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: LoginPage());
    } else {
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'FontsFree-Net-SFProDisplay'),
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: HomeScreen());
    }
  }
}
