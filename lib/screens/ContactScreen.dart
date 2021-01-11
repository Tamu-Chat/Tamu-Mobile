import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamu_chat/components/AppBar.dart';
import 'package:tamu_chat/components/BotttomNavigationBar.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<ContactScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: customerAppBar("Kişilerim"),
        body: Column(children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Center(
              child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Contact',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[],
            ),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.06,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'W.I.P.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.05),
              children: <TextSpan>[],
            ),
          )
        ]),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
