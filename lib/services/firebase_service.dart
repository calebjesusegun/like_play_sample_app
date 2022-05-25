import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:likeplay_likeplay_chat_app/app/app.logger.dart';

class FirebaseService {
  final log = getLogger('FirebaseService');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String currentUserId = '';
  static String currentUserName = '';

  String currentUserIdValue() {
    return currentUserId;
  }

  String currentUserNameValue() {
    return currentUserName;
  }

  Future<User?> createUser(String name, String email, String password) async {
    // FirebaseAuth _auth = FirebaseAuth.instance;

    // FirebaseFirestore _firestore = FirebaseFirestore.instance;

    try {
      UserCredential userCrendetial = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      log.i("Account created Succesfull");

      userCrendetial.user!.updateDisplayName(name);

      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "name": name,
        "email": email,
        "status": "Unavalible",
        "uid": _auth.currentUser!.uid,
        'timestamp': FieldValue.serverTimestamp(),
      });

      return userCrendetial.user;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  Future<User?> logIn(String email, String password) async {
    currentUserId = _auth.currentUser!.uid;
    currentUserName = _auth.currentUser!.displayName!;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      log.i("Login Sucessfull");
      _firestore.collection('users').doc(_auth.currentUser!.uid).get().then(
          (value) => userCredential.user!.updateDisplayName(value['name']));

      return userCredential.user;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  Stream<QuerySnapshot<Object?>>? getListOfUsers() {
    // FirebaseFirestore _firestore = FirebaseFirestore.instance;
    // FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      final Stream<QuerySnapshot> _usersStream = _firestore
          .collection('users')
          .orderBy('timestamp', descending: false)
          .snapshots();
      return _usersStream;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  Stream<DocumentSnapshot<Object?>>? getListOfUsersForUsername(
      Map<String, dynamic> userMap) {
    try {
      final Stream<DocumentSnapshot<Object?>>? _usersStream =
          _firestore.collection("users").doc(userMap['uid']).snapshots();
      return _usersStream;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  Stream<QuerySnapshot<Object?>>? getSpecificChatRoom(String chatRoomId) {
    try {
      final Stream<QuerySnapshot<Object?>>? _usersStream = _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .orderBy("time", descending: false)
          .snapshots();
      return _usersStream;
    } catch (e) {
      log.e(e);
      return null;
    }
  }

  onSendMessage(
      String chatRoomId, String message, messageTextController) async {
    if (message.isNotEmpty) {
      log.i('hello');
      Map<String, dynamic> messages = {
        "sendby": _auth.currentUser!.displayName,
        "message": message,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };

      // _message.clear();
      messageTextController.clear();

      await _firestore
          .collection('chatroom')
          .doc(chatRoomId)
          .collection('chats')
          .add(messages);
    } else {
      log.i("Enter Some Text");
    }
  }
}
