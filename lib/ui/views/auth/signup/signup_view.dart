import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/ui/widgets/auth_textforfield.dart';
import 'package:tinkler/ui/widgets/independent_scale.dart';
import 'package:tinkler/ui/widgets/rounded_button.dart';
import 'package:tinkler/ui/widgets/tappable_richtext.dart';
import 'package:tinkler/ui/widgets/top_background.dart';

import 'signup_viewmodel.dart';

class SignupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignupViewModel>.reactive(
      viewModelBuilder: () => SignupViewModel(),
      builder: (context, model, child) {
        return ModalProgressHUD(
          inAsyncCall: model.isBusy,
          child: IndependentScale(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: Stack(
                  children: [
                    const TopBackground(),
                    CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: const _MainContent(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
  final FocusNode _displayFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context, SignupViewModel model) {
    return Form(
      child: Column(
        children: [
          AuthTextFormField(
            initialValue: model.displayName,
            hintString: 'Enter full name',
            onChanged: model.setDisplayName,
            focusNode: _displayFocusNode,
            onEditingComplete: _emailFocusNode.requestFocus,
            textInputAction: TextInputAction.next,
            iconData: MdiIcons.accountBox,
          ),
          AuthTextFormField(
            initialValue: model.email,
            hintString: 'Enter email',
            keyBoardType: TextInputType.emailAddress,
            onChanged: model.setEmail,
            focusNode: _emailFocusNode,
            onEditingComplete: _passwordFocusNode.requestFocus,
            textInputAction: TextInputAction.next,
            iconData: Icons.person,
          ),
          AuthTextFormField(
            initialValue: model.password,
            hintString: 'Enter password',
            onChanged: model.setPassword,
            focusNode: _passwordFocusNode,
            onEditingComplete: _confirmPasswordFocusNode.requestFocus,
            textInputAction: TextInputAction.next,
            iconData: Icons.lock,
            obscureText: true,
          ),
          AuthTextFormField(
            initialValue: model.confirmPassword,
            hintString: 'Confirm password',
            onChanged: model.setConfirmPassword,
            focusNode: _confirmPasswordFocusNode,
            onEditingComplete: model.signUpWithEmail,
            textInputAction: TextInputAction.done,
            iconData: Icons.phone_locked,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
