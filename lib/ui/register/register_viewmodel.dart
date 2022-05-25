import 'package:likeplay_likeplay_chat_app/app/app.locator.dart';
import 'package:likeplay_likeplay_chat_app/app/app.logger.dart';
import 'package:likeplay_likeplay_chat_app/app/app.router.dart';
import 'package:likeplay_likeplay_chat_app/constants/enum.dart';
import 'package:likeplay_likeplay_chat_app/services/firebase_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _firebaseService = locator<FirebaseService>();
  final _snackbarService = locator<SnackbarService>();
  final log = getLogger('LoginViewModel');

  String _email = '';
  String _password = '';
  String _name = '';

  //A setter for _Email
  void setEmail({required String email}) {
    _email = email.trim();
    notifyListeners();
  }

  //A setter for _Name
  void setName({required String name}) {
    _name = name.trim();
    notifyListeners();
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

  void goToLoginView() {
    _navigationService.back();
  }

  void setLoadingValue(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Future<void> createUser() async {
    log.i('Email $_email');
    log.i('Password $_password');
    if (_email.isNotEmpty && _password.isNotEmpty && _name.isNotEmpty) {
      setBusy(true);
      setLoadingValue(true);
      await _firebaseService.createUser(_name, _email, _password).then((user) {
        if (user != null) {
          log.i("Sign Up Sucessfull");
          setLoadingValue(false);
          _snackbarService.showCustomSnackBar(
            variant: SnackBarType.success,
            message: 'You have successfully created a user',
            title: 'Success',
            duration: const Duration(seconds: 4),
            onTap: (_) {
              log.i('Sucess Message Event closed');
            },
            mainButtonTitle: 'Close',
            onMainButtonTapped: () => setDismissValue(true),
          );
          _navigationService.navigateTo(Routes.loginView);
        } else {
          setBusy(false);
          setLoadingValue(false);
          log.i("Login Failed");
          _snackbarService.showCustomSnackBar(
            variant: SnackBarType.error,
            message:
                'kindly confirm that you entered the right authentication details',
            title: 'Invalid Email and Password',
            duration: const Duration(seconds: 4),
            onTap: (_) {
              log.i('Error Message Event closed');
            },
            mainButtonTitle: 'Close',
            onMainButtonTapped: () => log.i('Undo the action!'),
          );
        }
      });
    } else {
      setBusy(false);
      setLoadingValue(false);
      log.i("Kindly fill form correctly");
      _snackbarService.showCustomSnackBar(
        variant: SnackBarType.error,
        message: 'Kindly fill the form correctly',
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
