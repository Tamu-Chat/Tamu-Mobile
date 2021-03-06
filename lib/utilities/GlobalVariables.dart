import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp/stomp.dart';
import 'package:tamu_chat/model/LanguageList.dart';
import 'package:tamu_chat/model/Message.dart';
import 'package:tamu_chat/model/User.dart';
import 'package:tamu_chat/utilities/Constants.dart';
import "package:stomp/vm.dart" show connect;
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

var isNetworkAvaible = false;
var selectedLanguagePack = LanguageList(0, "Türkçe", "tr", "TUR");
var selectedIndex = 1;
UserProfile currentUser;
String chatWith;
String chatWithUid;
StompClient currentClient;
List<UserProfile> contactList = [];
List<String> chatScreenList = [];

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
      login: loginString,
      passcode: passcodeString,
      heartbeat: [10000, 30000]).then((StompClient client) {
    currentClient = client;
  });
}

subscribeChannels() {
  currentClient.subscribeJson(currentUser.uid, "/queue/${currentUser.uid}",
      (headers, message) {
    //addMessage(Message(message['from'], message['message'], 1));
  });
}

Future<http.Response> loginCall(username, phonenumber, uid) {
  final ioc = new HttpClient();
  ioc.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  final http = new IOClient(ioc);

  return http.post(
    serverUrl + "/api/tamuChat",
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'phonenumber': phonenumber,
      'uid': uid,
      'profile_picture': '-',
      'about': 'Müsait'
    }),
  );
}

Future<void> login(username, phonenumber, uid) async {
  var response = await loginCall(username, phonenumber, uid);
  if (response.statusCode == 200) {
    currentUser = UserProfile(
        username: username,
        phonenumber: phonenumber,
        uid: uid,
        profilePicture: '-',
        about: 'Müsait');
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
      contactList.add(UserProfile.fromJson(x));
    }
  }
}
