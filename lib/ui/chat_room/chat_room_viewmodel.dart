import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:likeplay_likeplay_chat_app/app/app.locator.dart';
import 'package:likeplay_likeplay_chat_app/app/app.logger.dart';
import 'package:likeplay_likeplay_chat_app/services/firebase_service.dart';
import 'package:likeplay_likeplay_chat_app/services/image_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatRoomViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final log = getLogger('ChatRoomViewModel');
  final _imageService = locator<ImageService>();
  final _firebaseService = locator<FirebaseService>();

  String _message = '';

  final String _currentUserName = FirebaseService.currentUserName;

  String get currentUserName => _currentUserName;

  String setMessage({required String message}) {
    _message = _message.trim();
    notifyListeners();
    return _message;
  }

  Stream<DocumentSnapshot<Object?>>? getListOfUsersForUsername(
      Map<String, dynamic> userMap) {
    return _firebaseService.getListOfUsersForUsername(userMap);
  }

  Stream<QuerySnapshot<Object?>>? getSpecificChatRoom(String chatRoomId) {
    return _firebaseService.getSpecificChatRoom(chatRoomId);
  }

  void goToChatView() {
    _navigationService.back();
  }

  Future getUserImage(String chatRoomId) async {
    _imageService.getImage(chatRoomId);
  }

  Future sendUserMessage(String chatRoomId) async {
    _firebaseService.onSendMessage(
        chatRoomId, messageTextController.text, messageTextController);
  }

  TextEditingController get messageTextController => _messageTextController;
  final _messageTextController = TextEditingController();
}
