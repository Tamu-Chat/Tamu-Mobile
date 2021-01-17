import 'package:flutter/material.dart';

customerAppBar(String pageName) {
  return AppBar(
    shadowColor: Colors.transparent,
    elevation: 0,
    automaticallyImplyLeading: false,
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.search,
        ),
        tooltip: 'Arama',
        onPressed: () {
          //
        },
      )
    ],
    title: Row(children: <Widget>[
      Text(
        pageName,
        style: TextStyle(
            fontSize: 36, fontWeight: FontWeight.bold, letterSpacing: .5),
      ),
    ]),
  );
}
