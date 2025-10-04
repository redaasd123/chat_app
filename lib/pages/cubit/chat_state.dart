part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccessState extends ChatState {
  List<Message> messages = [];

  ChatSuccessState({required this.messages});
}
