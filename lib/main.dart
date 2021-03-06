import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:tamu_chat/model/User.dart';
import 'package:tamu_chat/screens/HomeScreen.dart';
import 'package:tamu_chat/screens/LoginScreen.dart';
import 'package:tamu_chat/utilities/Constants.dart';
import 'package:tamu_chat/utilities/GlobalVariables.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var username = prefs.getString('username');
  var phonenumber = prefs.getString('phonenumber');
  var uid = prefs.getString('uid');
  var profilePicture = prefs.getString('profilePicture');
  var about = prefs.getString('about');

  if (username != null) {
    currentUser = UserProfile(
        username: username,
        phonenumber: phonenumber,
        uid: uid,
        profilePicture: profilePicture,
        about: about);
  }

  await Firebase.initializeApp();

  runApp(MyApp());
}

void timee() {
  Future.delayed(Duration(seconds: 1)).then((_) async {
    if (currentClient == null || currentClient.isDisconnected) {
      await connectStomp();
      subscribeChannels();
    }
    timee();
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget screen = HomeScreen();
    if (currentUser == null) {
      screen = LoginPage();
    } else {
      timee();
    }

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Colors.blue,
            appBarTheme: AppBarTheme(
              color: Colors.blueGrey,
              shadowColor: Colors.transparent,
            ),
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.blueGrey,
                  displayColor: Colors.blueGrey,
                ),
            cardTheme: CardTheme(color: Colors.white60)),
        darkTheme: ThemeData.dark().copyWith(primaryColor: Colors.black12),
        themeMode: ThemeMode.light,
        home: screen);
  }
}
