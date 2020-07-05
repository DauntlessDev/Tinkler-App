import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/components/centered_circular_indicator.dart';
import 'package:tinkler/ui/components/rounded_button.dart';
import 'package:tinkler/ui/components/tappable_richtext.dart';
import 'package:tinkler/ui/components/top_background.dart';

import '../../../constants.dart';
import 'signup_viewmodel.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.nonReactive(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                const TopBackground(),
                const _MainContent(),
                const _BusyView(),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SignupViewModel(),
    );
  }
}

class _MainContent extends ViewModelWidget<SignupViewModel> {
  const _MainContent({
    Key key,
  }) : super(key: key, reactive: false);

  @override
  Widget build(BuildContext context, SignupViewModel model) {
    return AnimatedPadding(
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
                style: welcomeStyle,
              ),
            ),
            const Spacer(flex: 1),
            _SignupForm(),
            const SizedBox(height: 20),
            RoundedButton(
              onPressed: model.signUpWithEmail,
              text: 'Continue',
              color: darkBlueColor,
            ),
            const SizedBox(height: 10),
            TappableRichText(
              firstString: 'Already have an account?',
              secondString: 'Login.',
              onTap: model.navigateToLogin,
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}

class _SignupForm extends ViewModelWidget<SignupViewModel> {
  _SignupForm({
    Key key,
  }) : super(key: key, reactive: false);
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
            decoration: const InputDecoration(
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
              decoration: const InputDecoration(
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
