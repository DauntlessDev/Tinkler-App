import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/components/centered_circular_indicator.dart';
import 'package:tinkler/ui/components/rounded_button.dart';
import 'package:tinkler/ui/components/top_background.dart';

import '../../../constants.dart';
import 'signup_viewmodel.dart';

class SignupView extends StatelessWidget {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              const TopBackground(),
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
                      const Align(
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
                      const Spacer(flex: 1),
                      Form(
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: model.email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Enter email',
                                icon: Icon(Icons.person),
                              ),
                              onEditingComplete:
                                  _passwordFocusNode.requestFocus,
                              onChanged: model.setEmail,
                            ),
                            TextFormField(
                                initialValue: model.password,
                                textInputAction: TextInputAction.next,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  hintText: 'Enter password',
                                  icon: Icon(Icons.lock),
                                ),
                                onEditingComplete:
                                    _confirmPasswordFocusNode.requestFocus,
                                focusNode: _passwordFocusNode,
                                onChanged: model.setPassword),
                            TextFormField(
                              initialValue: model.confirmPassword,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Confirm password',
                                icon: Icon(Icons.phone_locked),
                              ),
                              onEditingComplete: model.signUpWithEmail,
                              focusNode: _confirmPasswordFocusNode,
                              onChanged: model.setConfirmPassword,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      RoundedButton(
                        onPressed: model.signUpWithEmail,
                        text: 'Continue',
                        color: darkBlueColor,
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: model.navigateToLogin,
                        child: RichText(
                          text: const TextSpan(
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
                      const Spacer(flex: 4),
                    ],
                  ),
                ),
              ),
              _BusyView(),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}

class _BusyView extends ViewModelWidget<SignupViewModel> {
  const _BusyView({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, SignupViewModel model) {
    if (model.isBusy) {
      return CenteredCircularIndicator();
    }
    return Container();
  }
}
