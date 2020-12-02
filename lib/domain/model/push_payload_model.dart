import 'dart:io';

class PushPayloadModel {
  int messageId = -1;
  PushCategory category = PushCategory.none;
  PushPayloadModel();

  factory PushPayloadModel.fromJson(Map<String, dynamic> json) {
    final body = Platform.isIOS ? json : json['data'].cast<String, dynamic>();
    if (body != null && body is Map<String, dynamic>) {
      var entity = PushPayloadModel();
      return entity;
    }
    return null;
  }
}

enum PushCategory { none, newChat, newMessage, newReply, updateMessage }
