import 'package:flutter/material.dart';
import 'package:tamu_chat/screens/HomeScreen.dart';
import 'package:tamu_chat/utilities/GlobalVariables.dart';
import 'package:tamu_chat/utilities/Constants.dart';
import 'package:easy_localization/easy_localization.dart';

import "package:stomp/stomp.dart";
import "package:stomp/vm.dart" show connect;

Future<void> main() async {
  await connect(serverUrl,
      port: 61613,
      host: "/",
      login: "***",
      passcode: "***",
      heartbeat: [10000, 30000]).then((StompClient client) {
    currentClient = client;
  });
  currentClient.subscribeString("/mustafa", "/queue/mustafa_fatih",
      (Map<String, String> headers, String message) {
    messages.add(new MessageInstance(0, message));
  });
  currentClient.subscribeString("/fatih", "/queue/fatih_mustafa",
      (Map<String, String> headers, String message) {
    messages.add(new MessageInstance(1, message));
  });
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
    return MaterialApp(
        theme: ThemeData(fontFamily: 'FontsFree-Net-SFProDisplay'),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: HomeScreen());
  }
}
