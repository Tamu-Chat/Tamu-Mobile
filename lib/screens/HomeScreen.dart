import 'package:flutter/material.dart';
import 'package:tamu_chat/components/AppBar.dart';
import 'package:tamu_chat/components/BotttomNavigationBar.dart';
import 'package:tamu_chat/screens/ChatScreen.dart';

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
    return Scaffold(
      appBar: customerAppBar("Mesajlar"),
      body: new ListView.builder(
          itemCount: 3, //contactList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return GestureDetector(
              onTap: () async {
                //chatWith = contactList[index].username;
                //chatWithUid = contactList[index].uid;
                //await refreshChats();
                //Navigator.push(context,
                //MaterialPageRoute(builder: (context) => ChatScreen()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.blueGrey,
                        size: 62,
                      ),
                      //title: Text(contactList[index].username),
                      //subtitle:
                      //Text("Numara: " + contactList[index].phonenumber),
                    )
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: BottomBar(),
    );
  }
}
