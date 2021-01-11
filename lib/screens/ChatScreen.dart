import 'package:flutter/material.dart';
import 'package:stomp/stomp.dart';
import 'package:stomp/vm.dart';
import 'package:tamu_chat/components/AppBar.dart';
import 'package:tamu_chat/utilities/GlobalVariables.dart';
import 'package:tamu_chat/utilities/Constants.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<ChatScreen> {
  @override
  void initState() {
    _timer();
    super.initState();
  }

  void _timer() {
    Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {});
      _timer();
    });
  }

  var _messageBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: customerAppBar("Mustafa"),
          body: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  var i = messages.length - (1 + index);

                  if (messages[i].type == 0) {
                    return Container(
                        height: 40,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            shape: BoxShape.rectangle,
                            color: Colors.amber),
                        //color: Colors.yellowAccent,
                        child: Text(
                          messages[i].body,
                        ));
                  }

                  return Container(
                      height: 40,
                      width: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          shape: BoxShape.rectangle,
                          color: Colors.greenAccent),
                      child: Text(
                        messages[i].body,
                      ));
                },
              )),
              TextField(
                  controller: _messageBody,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blueGrey,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed: () async {
                        if (currentClient.isDisconnected) {
                          print('aa');
                          await connect("serverUrl",
                                  port: 61613,
                                  host: "/",
                                  login: "***",
                                  passcode: "***",
                                  heartbeat: [10000, 30000])
                              .then((StompClient client) {
                            currentClient = client;
                          });
                          currentClient.subscribeString(
                              "/fatih", "/queue/fatih_mustafa",
                              (Map<String, String> headers, String message) {
                            messages.add(new MessageInstance(1, message));
                          });
                          currentClient.subscribeString(
                              "/mustafa", "/queue/mustafa_fatih",
                              (Map<String, String> headers, String message) {
                            messages.add(new MessageInstance(0, message));
                          });
                        }
                        currentClient.sendString(
                            "/queue/mustafa_fatih", _messageBody.text);
                        _messageBody.text = '';
                      },
                    ),
                  ))
            ],
          ) //bottomNavigationBar: BottomBar(),
          ),
    );
  }
}
