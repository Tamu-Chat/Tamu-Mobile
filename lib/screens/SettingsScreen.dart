import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:tamu_chat/components/AppBar.dart';
import 'package:tamu_chat/components/BotttomNavigationBar.dart';
import 'package:tamu_chat/model/LanguageList.dart';
import 'package:tamu_chat/model/ThemeList.dart';

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

  List<ThemeList> _dropdownItemsTheme = [
    ThemeList('Açık', ThemeMode.light),
    ThemeList('Koyu', ThemeMode.dark),
  ];

  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  List<DropdownMenuItem<LanguageList>> _dropdownMenuItems;
  LanguageList _selectedLanguagePack;

  List<DropdownMenuItem<ThemeList>> _dropdownMenuItemsTheme;
  ThemeList _selectedThemePack;

  @override
  void initState() {
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedLanguagePack = _dropdownMenuItems[0].value;
    _dropdownMenuItemsTheme = buildDropDownMenuItemsTheme(_dropdownItemsTheme);
    _selectedThemePack = _dropdownMenuItemsTheme[0].value;
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

  List<DropdownMenuItem<ThemeList>> buildDropDownMenuItemsTheme(
      List listItems) {
    List<DropdownMenuItem<ThemeList>> items = List();
    for (ThemeList listItem in listItems) {
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
    return Scaffold(
      appBar: customerAppBar("Ayarlar"),
      body: Column(children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
        Center(
            child: Text(
          'Tema Seçiniz',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.07,
            fontWeight: FontWeight.bold,
          ),
        )),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.06,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.0),
          child: DropdownButton<ThemeList>(
              isExpanded: true,
              value: _selectedThemePack,
              items: _dropdownMenuItemsTheme,
              dropdownColor: Colors.blueGrey[900],
              onChanged: (value) {
                setState(() {
                  Get.changeThemeMode(value.theme);
                  //context.locale = Locale(value.countryCode, value.localeCode);
                  _selectedThemePack = value;
                  //selectedLanguagePack = value;
                  //saveLocalePref();
                });
              }),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
        Center(
            child: Text(
          tr('choose_language'),
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.07,
            fontWeight: FontWeight.bold,
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
              dropdownColor: Colors.blueGrey[900],
              onChanged: (value) {
                setState(() {
                  _selectedLanguagePack = value;
                  selectedLanguagePack = value;
                  saveLocalePref();
                });
              }),
        ),
      ]),
      bottomNavigationBar: BottomBar(),
    );
  }
}
