import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/services/auth_service.dart';

class SignupViewModel extends BaseViewModel {
  final _auth = locator<AuthService>();
  final _dialog = locator<DialogService>();
  final _navigation = locator<NavigationService>();

  Future navigateToLogin() async {
    final _navigationService = locator<NavigationService>();
    _navigationService.back();
  }

  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  String get username => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  void setEmail(String input) => _email = input;
  void setPassword(String input) => _password = input;
  void setConfirmPassword(String input) => _confirmPassword = input;

  Future signUpWithEmail() async {
    setBusy(true);
    try {
      if (_email.isNotEmpty &&
          _password.isNotEmpty &&
          _confirmPassword.isNotEmpty) {
        return await _auth.createWithEmailAndPassword(
            email: _email, password: _password);
      } else if (_password != _confirmPassword) {
        throw PlatformException(
            code: 'PASSWORD_NOT_EQUAL', message: 'Password does not match.');
      } else {
        throw PlatformException(
            code: 'EMPTY_FIELDS', message: 'Please fill out all fields.');
      }
    } on PlatformException catch (e) {
      _dialog.showDialog(
        title: 'Sign-up Failed',
        description: e.message,
      );
    } finally {
      setBusy(false);
      _navigation.back();
    }
  }
}
