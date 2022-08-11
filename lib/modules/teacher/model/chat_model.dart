class ChatModel {
  String? timeStamp;
  String? msg;
  bool? isMe;

  ChatModel({this.timeStamp, this.msg, this.isMe});

  ChatModel.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    msg = json['msg'];
    isMe = json['isMe'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeStamp'] = this.timeStamp;
    data['msg'] = this.msg;
    data['isMe'] = this.isMe;
    return data;
  }
}
