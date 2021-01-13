import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamu_chat/screens/ContactScreen.dart';
import 'package:tamu_chat/screens/HomeScreen.dart';
import 'package:tamu_chat/screens/SettingsScreen.dart';
import 'package:tamu_chat/utilities/GlobalVariables.dart';

class BottomBar extends StatefulWidget {
  BottomBar({Key key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Future<void> _onItemTapped(int index) async {
    if (index == 0) {
      await fetchUsers();
    }
    setState(() {
      selectedIndex = index;

      if (index == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ContactScreen()));
      } else if (index == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (index == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SettingsScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      backgroundColor: Colors.transparent,
      elevation: 12,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.person,
            ),
            label: 'Kişilerim',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.bubble_left,
            ),
            label: 'Mesajlar',
            backgroundColor: Colors.white),
        BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            label: 'Ayarlar',
            backgroundColor: Colors.white),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.blueGrey[700],
      unselectedItemColor: Colors.blueGrey,
      onTap: _onItemTapped,
    );
  }
}
