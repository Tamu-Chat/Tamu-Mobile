import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp/stomp.dart';
import 'package:tamu_chat/model/LanguageList.dart';

var isNetworkAvaible = false;
var selectedLanguagePack = LanguageList(0, "Türkçe", "tr", "TUR");
var selectedIndex = 0;
StompClient currentClient;

class MessageInstance {
  int type;
  String body;

  MessageInstance(this.type, this.body);
}

var messages = [];

saveLocalePref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setInt('languageValue', selectedLanguagePack.value);
  prefs.setString('languageName', selectedLanguagePack.name);
  prefs.setString('countryCode', selectedLanguagePack.countryCode);
  prefs.setString('localeCode', selectedLanguagePack.localeCode);
}

getLocalePref() async {
  int value;
  String name;
  String countryCode;
  String localeCode;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  value = prefs.getInt('languageValue');
  name = prefs.getString('languageName');
  countryCode = prefs.getString('countryCode');
  localeCode = prefs.getString('localeCode');

  if (value == null) {
    value = 1;
    name = "Türkçe";
    countryCode = "tr";
    localeCode = "TUR";
    selectedLanguagePack = LanguageList(value, name, countryCode, localeCode);
    saveLocalePref();
  } else {
    selectedLanguagePack = LanguageList(value, name, countryCode, localeCode);
  }
}

checkConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      isNetworkAvaible = true;
    }
  } on SocketException catch (_) {
    isNetworkAvaible = false;
  }
}
