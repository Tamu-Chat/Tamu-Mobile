import 'package:flutter/material.dart';
import 'package:tamu_chat/components/AppBar.dart';
import 'package:tamu_chat/components/BotttomNavigationBar.dart';
import 'package:tamu_chat/model/Message.dart';
import 'package:tamu_chat/utilities/GlobalVariables.dart';

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
    Future.delayed(Duration(seconds: 1)).then((_) async {
      if (currentClient == null) {
        await connectStomp();
        subscribeChannels(chatWith, currentUsername);
      } else if (currentClient.isDisconnected) {
        await connectStomp();
        subscribeChannels(chatWith, currentUsername);
      }
      refreshChats();
      setState(() {});
      _timer();
    });
  }

  var _messageBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customerAppBar(chatWith),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              var i = messages.length - (1 + index);

              if (messages[i].type == 0) {
                return Row(
                  children: [
                    Container(height: 40, width: 200),
                    Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            shape: BoxShape.rectangle,
                            color: Colors.black54),
                        //color: Colors.yellowAccent,
                        child: Center(
                          child: Text(
                            messages[i].body,
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                );
              }

              return Row(
                children: [
                  Container(
                      height: 40,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          shape: BoxShape.rectangle,
                          color: Colors.black87),
                      child: Center(
                          child: Text(
                        messages[i].body,
                        style: TextStyle(color: Colors.white),
                      ))),
                  Container(height: 40, width: 200),
                ],
              );
            },
          )),
          TextField(
              controller: _messageBody,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey,
                suffixIcon: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (currentClient.isDisconnected) {
                      await connectStomp();
                      subscribeChannels(chatWith, currentUsername);
                    }
                    currentClient.sendJson("/queue/$currentUsername", {
                      'from': currentUsername,
                      'message': _messageBody.text
                    });
                    /*currentClient.sendString(
                        "/queue/${currentUsername}_$chatWith",
                        _messageBody.text);*/
                    addMessage(Message(chatWith, _messageBody.text, 0));
                    _messageBody.text = '';
                  },
                ),
              ))
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
