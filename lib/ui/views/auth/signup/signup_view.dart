import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/widgets/rounded_button.dart';
import 'package:tinkler/ui/widgets/tappable_richtext.dart';
import 'package:tinkler/ui/widgets/top_background.dart';

import 'signup_viewmodel.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.nonReactive(
      builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.isBusy,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Stack(
                children: [
                  const TopBackground(),
                  const _MainContent(),
                ],
              ),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sign up to \nTinkler!',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            const Spacer(flex: 1),
            _SignupForm(),
            const SizedBox(height: 20),
            RoundedButton(
              onPressed: model.signUpWithEmail,
              text: 'Continue',
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 10),
            TappableRichText(
              firstString: 'Already have an account? ',
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
  final FocusNode _emailFocusNode = FocusNode();
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
              hintText: 'Enter full name',
              icon: Icon(MdiIcons.accountBox),
            ),
            onEditingComplete: _passwordFocusNode.requestFocus,
            onChanged: model.setEmail,
          ),
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
