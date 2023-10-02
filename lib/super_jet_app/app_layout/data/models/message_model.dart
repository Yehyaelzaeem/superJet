import 'package:superjet/super_jet_app/app_layout/domain/entities/message_entities.dart';

class MessageModel extends MessageEntities{
  MessageModel({required super.dateTime, required super.receiverId, required super.senderId, required super.text});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
        dateTime: json['dateTime'],
        receiverId: json['receiverId'],
        senderId: json['senderId'],
        text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime':dateTime,
      'receiverId':receiverId,
      'senderId':senderId,
      'text':text,
    };
  }
}