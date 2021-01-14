import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stomp/stomp.dart';
import 'package:tamu_chat/model/LanguageList.dart';
import 'package:tamu_chat/model/Message.dart';
import 'package:tamu_chat/model/User.dart';
import 'package:tamu_chat/utilities/Constants.dart';
import "package:stomp/vm.dart" show connect;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

var isNetworkAvaible = false;
var currentUsername;
var currentUserPhoneNumber;
var selectedLanguagePack = LanguageList(0, "Türkçe", "tr", "TUR");
var selectedIndex = 1;
String chatWith;
StompClient currentClient;
List<User> contactList = [];
Future<Database> database;

class MessageInstance {
  int type;
  String body;

  MessageInstance(this.type, this.body);
}

var messages = [];
var allMessages = [];

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

connectStomp() async {
  await connect(baseServerUrl,
      port: 61613,
      host: "/",
      login: "***",
      passcode: "***",
      heartbeat: [10000, 30000]).then((StompClient client) {
    currentClient = client;
  });
}

subscribeChannels(chatWith, currentUsername) {
  currentClient.subscribeString(
      //"/$currentUsername", "/queue/a/b",
      "/$currentUsername",
      "/queue/${chatWith}_$currentUsername",
      (Map<String, String> headers, String message) {
    addMessage(Message(chatWith, message, 1));
  });
}

Future<http.Response> loginCall(username, phonenumber) {
  final ioc = new HttpClient();
  ioc.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);

  return http.post(
    serverUrl + "/api/tamuChat",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'username': username, 'phonenumber': phonenumber}),
  );
}

Future<void> login(username, phonenumber) async {
  var response = await loginCall(username, phonenumber);
  print(response.statusCode);
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  }
}

Future<http.Response> fetchUsersCall() {
  return http.get(serverUrl + "/api/tamuChat");
}

fetchUsers() async {
  var response = await fetchUsersCall();
  if (response.statusCode == 200) {
    contactList.clear();
    var data = jsonDecode(response.body);
    for (var x in data) {
      contactList.add(User.fromJson(x));
    }
  }
}

Future<void> addMessage(Message message) async {
  final Database db = await database;

  await db.insert(
    'messages',
    message.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

getMessages() async {
  final Database db = await database;

  final List<Map<String, dynamic>> maps = await db.query('messages');

  allMessages = List.generate(maps.length, (i) {
    return Message(
      maps[i]['withUsername'],
      maps[i]['body'],
      maps[i]['fromUser'],
    );
  });
}

refreshChats() async {
  await getMessages();
  messages.clear();
  for (var item in allMessages) {
    if (item.withUsername == chatWith) {
      messages.add(new MessageInstance(item.fromUser, item.body));
    }
  }
}
