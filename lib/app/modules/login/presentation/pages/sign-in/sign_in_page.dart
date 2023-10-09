import 'package:eden/app/modules/login/presentation/pages/sign-in/sign_in_controller.dart';
import 'package:eden/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ModularState<SignInPage, SignInController> {

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FlutterLogo(
                    size: 50.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text(
                      "Log In",
                      style: TextStyle(
                          fontSize: 30.0
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.90,
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Email"),
                            cursorColor: primaryColor,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "This field is required"),
                              EmailValidator(errorText: "Invalid email address"),
                            ]),
                            onChanged: (val) {
                              controller.setEmail(val);
                            },
                          ),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Password"),
                              cursorColor: primaryColor,
                              validator: MultiValidator([
                                RequiredValidator(errorText: "Password is required"),
                                MinLengthValidator(6, errorText: "Minimum 6 character required"),
                              ]),
                              onChanged: (val) {
                                controller.setPassword(val);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(children: [
                              ElevatedButton(
                                child: Text(
                                  "Login".toUpperCase(),
                                  style: TextStyle(fontSize: 18, color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: primaryColor,
                                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                  ),
                                ),
                                onPressed: controller.signIn,
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: textColor, fontSize: 20.0),
                      children: <TextSpan>[
                        TextSpan(text: "Don't have an account? "),
                        TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(color: primaryColor),
                            recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Modular.to.pushNamed("/login/sign-up");
                            }
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}