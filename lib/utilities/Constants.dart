import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

final mailAccount = "smith@example.org"; // todo add mail address

const Color mainColor = Color(0xFF5ED40A);
const Color subColor = Color(0xFFF44336);

final serverUrl = '';

final alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  backgroundColor: Color(0xff0d082b),
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
  descTextAlign: TextAlign.center,
  animationDuration: Duration(milliseconds: 250),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(21.0),
  ),
  titleStyle: TextStyle(
    color: Colors.white,
  ),
  alertAlignment: Alignment.center,
);
