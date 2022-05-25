import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:likeplay_likeplay_chat_app/components/custom_textfield_container.dart';
import 'package:likeplay_likeplay_chat_app/constants/app_colors.dart';
import 'package:likeplay_likeplay_chat_app/ui/chat_room/chat_room_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ChatRoomView extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatRoomId;

  // ignore: use_key_in_widget_constructors
  const ChatRoomView({required this.chatRoomId, required this.userMap});

  // final TextEditingController _message = TextEditingController();
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  // File? imageFile;

  // Future getImage() async {
  //   ImagePicker _picker = ImagePicker();

  //   await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
  //     if (xFile != null) {
  //       imageFile = File(xFile.path);
  //       uploadImage();
  //     }
  //   });
  // }

  // Future uploadImage() async {
  //   String fileName = const Uuid().v1();
  //   int status = 1;

  //   await _firestore
  //       .collection('chatroom')
  //       .doc(chatRoomId)
  //       .collection('chats')
  //       .doc(fileName)
  //       .set({
  //     "sendby": _auth.currentUser!.displayName,
  //     "message": "",
  //     "type": "img",
  //     "time": FieldValue.serverTimestamp(),
  //   });

  //   var ref =
  //       FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

  //   var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
  //     await _firestore
  //         .collection('chatroom')
  //         .doc(chatRoomId)
  //         .collection('chats')
  //         .doc(fileName)
  //         .delete();

  //     status = 0;
  //   });

  //   if (status == 1) {
  //     String imageUrl = await uploadTask.ref.getDownloadURL();

  //     await _firestore
  //         .collection('chatroom')
  //         .doc(chatRoomId)
  //         .collection('chats')
  //         .doc(fileName)
  //         .update({"message": imageUrl});

  //     print(imageUrl);
  //   }
  // }

  // void onSendMessage() async {
  //   if (_message.text.isNotEmpty) {
  //     Map<String, dynamic> messages = {
  //       "sendby": _auth.currentUser!.displayName,
  //       "message": _message.text,
  //       "type": "text",
  //       "time": FieldValue.serverTimestamp(),
  //     };

  //     _message.clear();
  //     await _firestore
  //         .collection('chatroom')
  //         .doc(chatRoomId)
  //         .collection('chats')
  //         .add(messages);
  //   } else {
  //     print("Enter Some Text");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<ChatRoomViewModel>.reactive(
      viewModelBuilder: () => ChatRoomViewModel(),
      // onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: StreamBuilder<DocumentSnapshot>(
              stream: viewModel.getListOfUsersForUsername(userMap),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Column(
                    children: [
                      Text(
                        userMap['name'],
                        style: const TextStyle(color: Colors.black54),
                      ),
                      // Text(
                      //   snapshot.data!['status'],
                      //   style: const TextStyle(fontSize: 14),
                      // ),
                    ],
                  );
                } else {
                  return Container();
                }
              },
            ),
            backgroundColor: kGray20,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding: const EdgeInsets.only(left: 24, top: 10),
              child: RawMaterialButton(
                onPressed: () => viewModel.goToChatView(),
                elevation: 0.0,
                fillColor: kSecondaryColor20,
                child: const Icon(
                  Icons.chevron_left,
                  size: 24.0,
                  color: kSecondaryColor,
                ),
                padding: const EdgeInsets.all(4.0),
                shape: const CircleBorder(),
              ),
            ),
            // centerTitle: ,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height / 1.35,
                  width: size.width,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: viewModel.getSpecificChatRoom(chatRoomId),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data != null) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> map =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return MessageWidget(
                              context: context,
                              size: size,
                              map: map,
                              displayName: viewModel.currentUserName,
                            );
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedInputField(
                      width: size.width * 0.8,
                      controller: viewModel.messageTextController,
                      suffixIcon: IconButton(
                        onPressed: () => viewModel.getUserImage(chatRoomId),
                        icon: const Icon(Icons.photo),
                      ),
                      icon: Icons.email,
                      labelText: 'Send Message',
                      onChanged: (String value) {
                        viewModel.setMessage(message: value);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => viewModel.sendUserMessage(chatRoomId),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {Key? key,
      required this.size,
      required this.map,
      required this.context,
      required this.displayName})
      : super(key: key);
  final Size size;
  final Map<String, dynamic> map;
  final BuildContext context;
  final String displayName;

  @override
  Widget build(BuildContext context) {
    return map['type'] == "text"
        ? Container(
            width: size.width,
            alignment: map['sendby'] == displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              child: Text(
                map['message'],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: map['sendby'] == displayName
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: map['message'],
                  ),
                ),
              ),
              child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                decoration: BoxDecoration(border: Border.all()),
                alignment: map['message'] != "" ? null : Alignment.center,
                child: map['message'] != ""
                    ? Image.network(
                        map['message'],
                        fit: BoxFit.cover,
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          );
  }
}
