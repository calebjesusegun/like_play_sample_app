import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:likeplay_likeplay_chat_app/app/app.locator.dart';
import 'package:likeplay_likeplay_chat_app/app/app.router.dart';
import 'package:likeplay_likeplay_chat_app/components/snackbar_setup.dart';
import 'package:likeplay_likeplay_chat_app/ui/login/login_view.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  await setupSnackBarUI();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: getApplicationTheme(),
      // ignore: prefer_const_constructors
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
      navigatorKey: StackedService.navigatorKey,
      onGenerateRoute: StackedRouter().onGenerateRoute,
    );
  }
}
