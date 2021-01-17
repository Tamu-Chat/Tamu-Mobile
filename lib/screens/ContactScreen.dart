import 'package:flutter/material.dart';
import 'package:tamu_chat/components/AppBar.dart';
import 'package:tamu_chat/components/BotttomNavigationBar.dart';
import 'package:tamu_chat/screens/ChatScreen.dart';
import 'package:tamu_chat/utilities/GlobalVariables.dart';

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
    return Scaffold(
      appBar: customerAppBar("Kişilerim"),
      body: new ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return GestureDetector(
              onTap: () async {
                chatWith = contactList[index].username;
                chatWithUid = contactList[index].uid;
                await refreshChats();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
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
                      title: Text(contactList[index].username),
                      subtitle:
                          Text("Numara: " + contactList[index].phonenumber),
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
