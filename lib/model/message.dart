import 'package:chat_app/widget/constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
 final String message;
 final dynamic id;
 final Timestamp timestamp;

  Message({required this.timestamp,required this.id, required this.message});

factory Message.fromJson( jsonData)
{
  return Message(message: jsonData[kMessage],
  id: jsonData[kId],
  timestamp: jsonData[kCreatedAt]);

}

}