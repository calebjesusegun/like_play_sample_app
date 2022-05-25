import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:likeplay_likeplay_chat_app/app/app.locator.dart';
import 'package:likeplay_likeplay_chat_app/app/app.logger.dart';
import 'package:likeplay_likeplay_chat_app/app/app.router.dart';
import 'package:likeplay_likeplay_chat_app/services/firebase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ChatViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firebaseService = locator<FirebaseService>();
  final log = getLogger('ChatViewModel');

  final String _currentUserId = FirebaseService.currentUserId;

  String get currentUserId => _currentUserId;

  final String _currentUserName = FirebaseService.currentUserName;

  String get currentUserName => _currentUserName;

  void goToChatRoomView(String chatRoomId, Map<String, dynamic> userMapData) {
    _navigationService.navigateTo(Routes.chatRoomView,
        arguments: ChatRoomViewArguments(
            userMap: userMapData, chatRoomId: chatRoomId));
  }

  Stream<QuerySnapshot<Object?>>? displayUsers() {
    return _firebaseService.getListOfUsers();
  }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user1[0].toLowerCase().codeUnits[0]) {
      return '$user1$user2';
    } else {
      return '$user2$user1';
    }
  }

  void initialize() {
    displayUsers();
  }
}
