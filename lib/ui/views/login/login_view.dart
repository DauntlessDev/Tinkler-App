//view class
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stacked/stacked.dart';
import 'package:tinkler/constants.dart';
import 'package:tinkler/ui/components/rounded_button.dart';

import 'login_viewmodel.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => ModalProgressHUD(
        inAsyncCall: model.isBusy,
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image(
                        image: AssetImage('assets/images/top_background.png'),
                      ),
                    ),
                    Spacer(flex: 2),
                    Align(
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
                    Spacer(flex: 1),
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter email',
                              icon: Icon(Icons.person),
                            ),
                            onChanged: model.setEmail,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Enter password',
                              icon: Icon(Icons.lock),
                            ),
                            onChanged: model.setPassword,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    RoundedButton(
                      onPressed: model.signInWithEmail,
                      text: 'Continue',
                      color: blueColor,
                    ),
                    RoundedButton(
                      onPressed: () {},
                      text: 'Continue with Facebook',
                      color: darkBlueColor,
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: model.navigateToSignup,
                      child: RichText(
                        text: TextSpan(
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
                    Spacer(flex: 3),
                    Text(
                      'By continuing you agree to Terms & Conditions',
                      style: TextStyle(color: Colors.black45, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
