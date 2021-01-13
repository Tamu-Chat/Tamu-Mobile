import 'package:flutter/material.dart';
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: customerAppBar("Mesajlar"),
        body: Column(children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          GestureDetector(
              onTap: () {},
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
                        'Şu anlık rehberden mesaj gönderin',
                        style: TextStyle(fontSize: 24, color: Colors.blueGrey),
                      ),
                      subtitle: Text('Üzerinde çalısılıyor..'),
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
