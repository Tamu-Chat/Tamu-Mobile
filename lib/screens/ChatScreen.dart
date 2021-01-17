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
      refreshChats();
      setState(() {});
      _timer();
    });
  }

  var _messageBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
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
                return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            currentUser.username,
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              //color: Colors.black87
                            ),
                          ),
                        ),
                        Material(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                            topRight: Radius.circular(0),
                          ),
                          color: Colors.blueGrey,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              messages[i].body,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ));
              }

              return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          chatWith,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            //color: Colors.blueGrey
                          ),
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(0),
                          bottomRight: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                        color: Colors.white,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            messages[i].body,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'Poppins',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
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
                      subscribeChannels();
                    }
                    currentClient.sendJson("/queue/$chatWithUid", {
                      'from': currentUser.username,
                      'message': _messageBody.text
                    });
                    addMessage(Message(chatWith, _messageBody.text, 0));
                    _messageBody.text = '';
                  },
                ),
              ))
        ],
      ),
      //bottomNavigationBar: BottomBar(),
    );
  }
}
