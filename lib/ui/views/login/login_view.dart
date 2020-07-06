//view class
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/constants.dart';
import 'package:tinkler/ui/widgets/centered_circular_indicator.dart';
import 'package:tinkler/ui/widgets/rounded_button.dart';
import 'package:tinkler/ui/widgets/tappable_richtext.dart';
import 'package:tinkler/ui/widgets/top_background.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              const TopBackground(),
              _MainContent(),
              const _BusyView(),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}

class _MainContent extends ViewModelWidget<LoginViewModel> {
  _MainContent({
    Key key,
  }) : super(key: key, reactive: false);

  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return AnimatedPadding(
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
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ),
            const Spacer(flex: 1),
            _LoginForm(passwordFocusNode: _passwordFocusNode),
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
            TappableRichText(
              firstString: 'Don\'t have an account? ',
              secondString: 'Create one.',
              onTap: model.navigateToSignup,
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends ViewModelWidget<LoginViewModel> {
  const _LoginForm({
    Key key,
    @required this.passwordFocusNode,
  }) : super(key: key);
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context, LoginViewModel model) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            autofocus: true,
            initialValue: model.email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              hintText: 'Enter email',
              icon: Icon(Icons.person),
            ),
            onChanged: model.setEmail,
            onEditingComplete: passwordFocusNode.requestFocus,
          ),
          TextFormField(
            initialValue: model.password,
            textInputAction: TextInputAction.done,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Enter password',
              icon: Icon(Icons.lock),
            ),
            focusNode: passwordFocusNode,
            onChanged: model.setPassword,
            onEditingComplete: () {
              model.signInWithEmail();
              passwordFocusNode.unfocus();
            },
          ),
        ],
      ),
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
