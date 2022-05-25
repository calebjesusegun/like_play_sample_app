import 'package:likeplay_likeplay_chat_app/app/app.locator.dart';
import 'package:likeplay_likeplay_chat_app/app/app.logger.dart';
import 'package:likeplay_likeplay_chat_app/app/app.router.dart';
import 'package:likeplay_likeplay_chat_app/constants/enum.dart';
import 'package:likeplay_likeplay_chat_app/services/firebase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firebaseService = locator<FirebaseService>();
  final _snackbarService = locator<SnackbarService>();
  final log = getLogger('LoginViewModel');

  String _email = '';
  String _password = '';

  //A setter for _Email
  void setEmail({required String email}) {
    _email = email.trim();
    notifyListeners();
  }

  void goToRegisterView() {
    _navigationService.navigateTo(Routes.registerView);
  }

  //A setter for _Password
  void setPassword({required String password}) {
    _password = password.trim();
    notifyListeners();
  }

  bool isLoading = false;
  bool isDismiss = false;

  void setDismissValue(bool val) {
    isDismiss = val;
    notifyListeners();
  }

  void setLoadingValue(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Future<void> loginUser() async {
    log.i('Email $_email');
    log.i('Password $_password');
    if (_email.isNotEmpty && _password.isNotEmpty) {
      setBusy(true);
      setLoadingValue(true);
      await _firebaseService.logIn(_email, _password).then((user) {
        if (user != null) {
          log.i("Login Sucessfull");
          setLoadingValue(false);
          _snackbarService.showCustomSnackBar(
            variant: SnackBarType.success,
            message: 'You are successfully logged in ',
            title: 'Success',
            duration: const Duration(seconds: 4),
            onTap: (_) {
              log.i('Success Message Event closed');
            },
            mainButtonTitle: 'Close',
            onMainButtonTapped: () => setDismissValue(true),
          );
          _navigationService.navigateTo(Routes.chatView);
        } else {
          setBusy(false);
          setLoadingValue(false);
          log.i("Login Failed");
          _snackbarService.showCustomSnackBar(
            variant: SnackBarType.error,
            message:
                'kindly confirm that you entered the right login credentials',
            title: 'Invalid Login Credentials',
            duration: const Duration(seconds: 4),
            onTap: (_) {
              log.i('Error Message Event closed');
            },
            mainButtonTitle: 'Close',
            onMainButtonTapped: () => setDismissValue(true),
          );
        }
      });
    } else {
      setBusy(false);
      setLoadingValue(false);
      log.i("Please fill form correctly");
      _snackbarService.showCustomSnackBar(
        variant: SnackBarType.error,
        message: 'Kindly fill in the form field correctly',
        title: 'No Data Entered',
        duration: const Duration(seconds: 4),
        onTap: (_) {
          log.i('Error Message Event closed');
        },
        mainButtonTitle: 'Close',
        onMainButtonTapped: () => log.i('Undo the action!'),
      );
    }
  }
}
