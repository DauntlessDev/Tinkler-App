import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/app/router.gr.dart';
import 'package:tinkler/services/functional_services/authentication_service.dart';

class LoginViewModel extends BaseViewModel {
  final _auth = locator<AuthenticationService>();
  final _dialog = locator<DialogService>();

  Future navigateToSignup() async {
    final _navigationService = locator<NavigationService>();
    await _navigationService.navigateTo(Routes.signupViewRoute);
  }

  String _email = "";
  String _password = "";

  String get email => _email;
  String get password => _password;

  void setEmail(String input) => _email = input;
  void setPassword(String input) => _password = input;

  Future signInWithEmail() async {
    try {
      if (_email.isNotEmpty && _password.isNotEmpty) {
        setBusy(true);
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
      } else {
        throw PlatformException(
            code: 'EMPTY_FIELDS', message: 'Please fill out all fields.');
      }
    } on PlatformException catch (e) {
      await _dialog.showDialog(title: 'Login Failed', description: e.message);
    } finally {
      setBusy(false);
    }
  }
}
