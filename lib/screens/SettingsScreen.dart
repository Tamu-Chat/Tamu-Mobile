import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tamu_chat/components/AppBar.dart';
import 'package:tamu_chat/components/BotttomNavigationBar.dart';
import 'package:tamu_chat/model/LanguageList.dart';

import '../utilities/GlobalVariables.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsScreen> {
  List<LanguageList> _dropdownItems = [
    LanguageList(1, "Türkçe", "tr", "TUR"),
    LanguageList(2, "English", "en", "UK"),
  ];

  List<DropdownMenuItem<LanguageList>> _dropdownMenuItems;
  LanguageList _selectedLanguagePack;

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedLanguagePack = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<LanguageList>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<LanguageList>> items = List();
    for (LanguageList listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: customerAppBar("Ayarlar"),
        body: Column(children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.03,
          ),
          Center(
              child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: tr('choose_language'),
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[],
            ),
          )),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.06,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.0),
            child: DropdownButton<LanguageList>(
                isExpanded: true,
                value: _selectedLanguagePack,
                items: _dropdownMenuItems,
                style: TextStyle(color: Colors.black),
                dropdownColor: Colors.blueGrey,
                onChanged: (value) {
                  setState(() {
                    context.locale =
                        Locale(value.countryCode, value.localeCode);
                    _selectedLanguagePack = value;
                    selectedLanguagePack = value;
                    saveLocalePref();
                  });
                }),
          ),
        ]),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
