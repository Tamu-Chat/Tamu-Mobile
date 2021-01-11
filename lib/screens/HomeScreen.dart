import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tamu_chat/components/AppBar.dart';
import 'package:tamu_chat/components/BotttomNavigationBar.dart';
import 'package:tamu_chat/screens/ChatScreen.dart';
import 'package:tamu_chat/utilities/GlobalVariables.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: customerAppBar("Mesajlar"),
        body: Column(children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const ListTile(
                      leading: Icon(
                        Icons.person_rounded,
                        color: Colors.blueGrey,
                        size: 62,
                      ),
                      title: Text(
                        'Mustafa',
                        style: TextStyle(fontSize: 24, color: Colors.blueGrey),
                      ),
                      subtitle: Text('Yeni mesajları görmek için tıkla.'),
                    ),
                  ],
                ),
              )),
        ]),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
