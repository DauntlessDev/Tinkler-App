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
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
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
                      children: [
                        Spacer(flex: 10),
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
                              style:
                                  TextStyle(color: blackColor, fontSize: 15),
                              children: [
                                TextSpan(text: 'Don\'t have an account? '),
                                TextSpan(
                                  text: 'Create one.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(flex: 3),
                        Text(
                          'By continuing you agree to Terms & Conditions',
                          style:
                              TextStyle(color: Colors.black45, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(),
    );
  }
}
