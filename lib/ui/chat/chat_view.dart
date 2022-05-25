import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:likeplay_likeplay_chat_app/ui/chat/chat_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return ViewModelBuilder<ChatViewModel>.reactive(
      viewModelBuilder: () => ChatViewModel(),
      onModelReady: (viewModel) => viewModel.initialize(),
      builder: (context, viewModel, child) => SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Chat UI'),
                StreamBuilder<QuerySnapshot>(
                    stream: viewModel.displayUsers(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.lightBlueAccent,
                          ),
                        );
                      }

                      return Column(
                        children: snapshot.data!.docs.reversed
                            .where((element) =>
                                element.get('uid') != viewModel.currentUserId)
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;

                          return ListTile(
                            onTap: () {
                              String roomId = viewModel.chatRoomId(
                                  viewModel.currentUserName, data['name']);
                              viewModel.goToChatRoomView(roomId, data);
                            },
                            leading: const Icon(
                              Icons.account_box,
                              color: Colors.black54,
                            ),
                            title: Text(
                              data['name'],
                              style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500),
                            ),
                            subtitle: Text(data['email']),
                            trailing: const Icon(
                              Icons.chat,
                              color: Colors.black54,
                            ),
                          );
                        }).toList(),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
