import 'package:bloc/bloc.dart';
import 'package:chat_app/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../widget/constance.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessageCollection,
  );

  List<Message> messageList = [];

  void sendMessages({required String message, required String email}) {
    messages.add({
      kMessage: message,
      kCreatedAt: Timestamp.fromDate(DateTime.now()),
      'id': email,
    });
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSuccessState(messages: messageList));
    });
  }
}
