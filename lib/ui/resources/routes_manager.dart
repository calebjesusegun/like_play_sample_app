import 'package:flutter/material.dart';
import 'package:likeplay_likeplay_chat_app/ui/chat/chat_view.dart';
import 'package:likeplay_likeplay_chat_app/ui/login/login_view.dart';
import 'package:likeplay_likeplay_chat_app/ui/register/register_view.dart';
import 'package:likeplay_likeplay_chat_app/ui/resources/strings_manager.dart';

class Routes {
  static const String loginRoute = "/";
  static const String registerRoute = "/register";
  static const String chatRoute = "/chat";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      // case Routes.registerRoute:
      //   return MaterialPageRoute(builder: (_) => RegisterView());
      // case Routes.chatRoute:
      //   return MaterialPageRoute(builder: (_) => ChatView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
