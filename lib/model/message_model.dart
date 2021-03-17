class MessageModel
{
  int messageId;
  String senderId;
  String groupId;
  String messageContent ;

  MessageModel(
      {this.messageId, this.senderId, this.groupId, this.messageContent});

  MessageModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    messageId   = map["messageId"];
    messageContent = map["messageContent"];
    senderId    = map["senderId"];
    groupId   = map["groupId"];

  }

  toJson() {
    return {
      "messageId": messageId,
      "messageContent": messageContent,
      "senderId": senderId,
      "groupId": groupId ,

    };
  }
}