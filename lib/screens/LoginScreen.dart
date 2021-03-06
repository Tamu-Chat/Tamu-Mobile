import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tamu_chat/main.dart';
import 'package:tamu_chat/screens/HomeScreen.dart';
import 'package:tamu_chat/utilities/GlobalVariables.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final username = TextEditingController();
  final phonenumber = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                  color: Color(0xff6bceff),
                  /*gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    List: [Color(0xff6bceff), Color(0xff6bceff)]*/
                  //),
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(90))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Tamu Chat",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 44,
                            fontFamily: 'FontsFree-Net-SFProDisplay'),
                      )),
                  Spacer(),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black12, blurRadius: 5)
                        ]),
                    child: TextField(
                      controller: username,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person,
                          color: Color(0xff6bceff),
                        ),
                        hintText: 'Kullanıcı Adı',
                      ),
                    ),
                  ),
                  Spacer(),
                  IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Telefon Numarası',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'TR',
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () async {
                      if (phonenumber.text != "" && username.text != "") {
                        FirebaseAuth auth = FirebaseAuth.instance;

                        await auth.verifyPhoneNumber(
                          phoneNumber: '+9' + phonenumber.text,
                          timeout: const Duration(seconds: 60),
                          verificationCompleted:
                              (PhoneAuthCredential credential) async {
                            await auth.signInWithCredential(credential);
                          },
                          verificationFailed: (FirebaseAuthException e) {
                            if (e.code == 'invalid-phone-number') {
                              Alert(
                                context: context,
                                //style: alertStyle,
                                type: AlertType.warning,
                                title: "Dikkat",
                                desc: "Girilen numara geçersiz.",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Tamam",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    color: Color.fromRGBO(0, 179, 134, 1.0),
                                    radius: BorderRadius.circular(0.0),
                                  ),
                                ],
                              ).show();
                            } else {
                              print(e);
                            }
                          },
                          codeSent:
                              (String verificationId, int resendToken) async {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Dogrulama Kodu"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        TextField(
                                          controller: _codeController,
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("İptal"),
                                        textColor: Colors.white,
                                        color: Colors.blue,
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Onayla"),
                                        textColor: Colors.white,
                                        color: Colors.blue,
                                        onPressed: () async {
                                          if (_codeController.text != '') {
                                            String smsCode =
                                                _codeController.text.trim();

                                            PhoneAuthCredential
                                                phoneAuthCredential =
                                                PhoneAuthProvider.credential(
                                                    verificationId:
                                                        verificationId,
                                                    smsCode: smsCode);

                                            UserCredential credentials =
                                                await auth.signInWithCredential(
                                                    phoneAuthCredential);
                                            User tempUser = credentials.user;
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            await prefs.setString(
                                                'username', username.text);
                                            await prefs.setString('phonenumber',
                                                phonenumber.text);
                                            await prefs.setString(
                                                'uid', tempUser.uid);
                                            await prefs.setString(
                                                'profilePicture', '-');
                                            await prefs.setString(
                                                'about', 'Müsait');
                                            await login(username.text,
                                                phonenumber.text, tempUser.uid);
                                            timee();
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen()));
                                          }
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      } else {
                        Alert(
                                context: context,
                                title: "Dikkat!",
                                desc: "Site Bakım Aşamasındadır.")
                            .show();
                      }
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          color: Color(0xff6bceff),
                          /*gradient: LinearGradient(
                            List [
                              Color(0xff6bceff),
                              Color(0xFF00abff),
                            ],
                          ),*/
                          borderRadius: BorderRadius.all(Radius.circular(50))),
                      child: Center(
                        child: Text(
                          'Giriş Yap'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
