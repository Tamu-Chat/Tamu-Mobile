import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0d082b),
      body: Column(children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.03,
        ),
        Center(
            child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[],
          ),
        )),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.06,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'W.I.P.',
            style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.05),
            children: <TextSpan>[],
          ),
        )
      ]),
    );
  }
}
