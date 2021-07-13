import 'package:flutter/material.dart';
import 'package:teams_clone/screens/auth/email_login_screen.dart';
import 'package:teams_clone/screens/auth/email_signup_screen.dart';
import 'package:teams_clone/screens/auth/google_signin_button.dart';
import 'package:teams_clone/shared/app_state_builder.dart';
import 'package:teams_clone/utils/utilities.dart';

class MainAuthScreen extends StatefulWidget {
  @override
  _MainAuthScreenState createState() => _MainAuthScreenState();
}

class _MainAuthScreenState extends State<MainAuthScreen> {
  @override
  Widget build(BuildContext context) {
    return AppStateBuilder(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Container(
                height: 400,
                child: Image(
                  image: AssetImage("images/start.png"),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                      text: 'Welcome to ',
                      style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Teams Clone',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple))
                  ])),
              SizedBox(height: 10.0),
              Text(
                'Meet and work remotely while staying connected',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      onPressed: () =>
                          Utils.navigateTo(context, EmailLoginScreen()),
                      child: Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.deepPurple),
                  SizedBox(width: 20.0),
                  RaisedButton(
                      padding: EdgeInsets.only(left: 30, right: 30),
                      onPressed: () =>
                          Utils.navigateTo(context, EmailSignupScreen()),
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.deepPurple),
                ],
              ),
              SizedBox(height: 20.0),
              GoogleSignInButton(),
            ],
          ),
        ),
      ),
    );
  }
}
