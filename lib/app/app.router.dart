// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/chat/chat_view.dart';
import '../ui/chat_room/chat_room_view.dart';
import '../ui/login/login_view.dart';
import '../ui/register/register_view.dart';

class Routes {
  static const String loginView = '/';
  static const String registerView = '/register-view';
  static const String chatView = '/chat-view';
  static const String chatRoomView = '/chat-room-view';
  static const all = <String>{
    loginView,
    registerView,
    chatView,
    chatRoomView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.registerView, page: RegisterView),
    RouteDef(Routes.chatView, page: ChatView),
    RouteDef(Routes.chatRoomView, page: ChatRoomView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    RegisterView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const RegisterView(),
        settings: data,
      );
    },
    ChatView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ChatView(),
        settings: data,
      );
    },
    ChatRoomView: (data) {
      var args = data.getArgs<ChatRoomViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => ChatRoomView(
          chatRoomId: args.chatRoomId,
          userMap: args.userMap,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// ChatRoomView arguments holder class
class ChatRoomViewArguments {
  final String chatRoomId;
  final Map<String, dynamic> userMap;
  ChatRoomViewArguments({required this.chatRoomId, required this.userMap});
}
