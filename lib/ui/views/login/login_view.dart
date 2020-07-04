//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/constants.dart';
import 'package:tinkler/ui/components/centered_circular_indicator.dart';
import 'package:tinkler/ui/components/rounded_button.dart';
import 'package:tinkler/ui/components/top_background.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  final FocusNode _passwordFocusNode = FocusNode();

  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              const TopBackground(),
              AnimatedPadding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                duration: Duration(milliseconds: 220),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      const Spacer(flex: 10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Welcome to \nTinkler!',
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
                              onChanged: model.setEmail,
                              onEditingComplete:
                                  _passwordFocusNode.requestFocus,
                            ),
                            TextFormField(
                              initialValue: model.password,
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: 'Enter password',
                                icon: Icon(Icons.lock),
                              ),
                              focusNode: _passwordFocusNode,
                              onChanged: model.setPassword,
                              onEditingComplete: model.signInWithEmail,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      RoundedButton(
                        onPressed: model.signInWithEmail,
                        text: 'Continue',
                        color: darkBlueColor,
                      ),
                      RoundedButton(
                        onPressed: () {},
                        text: 'Continue with Facebook',
                        color: blueColor,
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: model.navigateToSignup,
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(color: blackColor, fontSize: 15),
                            children: [
                              TextSpan(text: 'Don\'t have an account? '),
                              TextSpan(
                                text: 'Create one.',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
              _BusyView(),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

class _BusyView extends ViewModelWidget<LoginViewModel> {
  const _BusyView({
    Key key,
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    if (model.isBusy) {
      return CenteredCircularIndicator();
    }
    return Container();
  }
}
