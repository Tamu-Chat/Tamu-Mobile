class Message {
  String withUsername;
  String body;
  int fromUser;

  Message(withUsername, body, fromUser) {
    this.withUsername = withUsername;
    this.body = body;
    this.fromUser = fromUser;
  }

  Map<String, dynamic> toMap() {
    return {
      'withUsername': withUsername,
      'body': body,
      'fromUser': fromUser,
    };
  }
}
