import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/components/rounded_button.dart';

import '../../../constants.dart';
import 'signup_viewmodel.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.nonReactive(
      builder: (context, model, child) => MainContent(),
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}

class MainContent extends ViewModelWidget<SignupViewModel> {
  const MainContent({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, SignupViewModel model) {
    return ModalProgressHUD(
      inAsyncCall: model.isBusy,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity:
                    MediaQuery.of(context).viewInsets.bottom < 50 ? 1.0 : 0.0,
                duration: Duration(milliseconds: 250),
                child: Image(
                  image: AssetImage('assets/images/top_background.png'),
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              AnimatedPadding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                duration: Duration(milliseconds: 220),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: <Widget>[
                      Spacer(flex: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign up to \nTinkler!',
                          style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                      ),
                      Spacer(flex: 1),
                      LoginForm(),
                      SizedBox(height: 20),
                      RoundedButton(
                        onPressed: model.signUpWithEmail,
                        text: 'Create Account',
                        color: darkBlueColor,
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: model.navigateToLogin,
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: blackColor, fontSize: 15),
                            children: [
                              TextSpan(text: 'Already have an account? '),
                              TextSpan(
                                text: 'Login',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(flex: 4),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginForm extends ViewModelWidget<SignupViewModel> {
  LoginForm({
    Key key,
  }) : super(key: key);

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, SignupViewModel model) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            initialValue: model.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: 'Enter email',
              icon: Icon(Icons.person),
            ),
            onEditingComplete: _passwordFocusNode.requestFocus,
            onChanged: model.setEmail,
          ),
          TextFormField(
              initialValue: model.password,
              textInputAction: TextInputAction.next,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Enter password',
                icon: Icon(Icons.lock),
              ),
              onEditingComplete: _confirmPasswordFocusNode.requestFocus,
              focusNode: _passwordFocusNode,
              onChanged: model.setPassword),
          TextFormField(
            initialValue: model.confirmPassword,
            textInputAction: TextInputAction.done,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Confirm password',
              icon: Icon(Icons.phone_locked),
            ),
            onEditingComplete: model.signUpWithEmail,
            focusNode: _confirmPasswordFocusNode,
            onChanged: model.setConfirmPassword,
          ),
        ],
      ),
    );
  }
}
