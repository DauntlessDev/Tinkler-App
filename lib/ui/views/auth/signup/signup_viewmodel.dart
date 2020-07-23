import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:tinkler/app/locator.dart';
import 'package:tinkler/model/profile.dart';
import 'package:tinkler/services/functional_services/authentication_service.dart';
import 'package:tinkler/services/functional_services/database_service.dart';

class SignupViewModel extends BaseViewModel {
  final _auth = locator<AuthenticationService>();
  final _database = locator<DatabaseService>();
  final _dialog = locator<DialogService>();
  final _navigation = locator<NavigationService>();

  Future navigateToLogin() async {
    final _navigationService = locator<NavigationService>();
    _navigationService.back();
  }

  String _displayName = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  String get displayName => _email;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _displayName;

  void setDisplayName(String input) => _displayName = input;
  void setEmail(String input) => _email = input;
  void setPassword(String input) => _password = input;
  void setConfirmPassword(String input) => _confirmPassword = input;

  void clearInputs() {
    _displayName = "";
    _email = "";
    _password = "";
    _confirmPassword = "";
  }

  Future signUpWithEmail() async {
    try {
      if (_displayName.isEmpty ||
          _email.isEmpty ||
          _password.isEmpty ||
          _confirmPassword.isEmpty) {
        throw PlatformException(
            code: 'EMPTY_FIELDS', message: 'Please fill out all fields.');
      } else if (_password != _confirmPassword) {
        throw PlatformException(
            code: 'PASSWORD_NOT_EQUAL', message: 'Password does not match.');
      } else if (_displayName.length < 5) {
        throw PlatformException(
            code: 'NAME_TOO_SHORT',
            message: 'Name is too short, please change.');
      } else {
        print('$_displayName , $_email , $_password , $_confirmPassword ');
        setBusy(true);

        await _auth.createWithEmailAndPassword(
            email: _email, password: _password);

        setSearchParam(String caseNumber) {
          List<String> caseSearchList = List();
          String temp = "";
          for (int i = 0; i < caseNumber.length; i++) {
            temp = temp + caseNumber[i];
            caseSearchList.add(temp);
          }
          return caseSearchList;
        }

        await _database.addProfile(
          Profile(
            email: _email,
            photoUrl: '',
            displayName: _displayName,
            caseSearch: setSearchParam(_displayName.toLowerCase()),
          ),
        );
        clearInputs();
        setBusy(false);
        _navigation.back();
      }
    } on PlatformException catch (e) {
      setBusy(false);
      await _dialog.showDialog(
        title: 'Sign-up Failed',
        description: e.message,
      );
    }
  }
}
