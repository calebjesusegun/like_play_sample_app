import 'package:likeplay_likeplay_chat_app/services/firebase_service.dart';
import 'package:likeplay_likeplay_chat_app/services/image_service.dart';
import 'package:likeplay_likeplay_chat_app/ui/chat/chat_view.dart';
import 'package:likeplay_likeplay_chat_app/ui/chat_room/chat_room_view.dart';
import 'package:likeplay_likeplay_chat_app/ui/login/login_view.dart';
import 'package:likeplay_likeplay_chat_app/ui/register/register_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  logger: StackedLogger(),
  routes: [
    MaterialRoute(page: LoginView, initial: true),
    MaterialRoute(
      page: RegisterView,
    ),
    MaterialRoute(
      page: ChatView,
    ),
    MaterialRoute(
      page: ChatRoomView,
    ),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: FirebaseService),
    LazySingleton(classType: ImageService),
    LazySingleton(classType: SnackbarService),
  ],
)
class AppSetup {
  /** Serves no purpose besides having an annotation attached to it */
}
