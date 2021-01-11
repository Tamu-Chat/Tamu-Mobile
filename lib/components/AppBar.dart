import 'package:flutter/material.dart';

customerAppBar(String pageName) {
  return AppBar(
    backgroundColor: Colors.white,
    shadowColor: Colors.transparent,
    elevation: 0,
    automaticallyImplyLeading: false,
    actions: <Widget>[
      IconButton(
        icon: const Icon(
          Icons.search,
          color: Colors.blueGrey,
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
            color: Colors.blueGrey,
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: .5),
      ),
    ]),
  );
}
