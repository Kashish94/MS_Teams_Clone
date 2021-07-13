import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/provider/appstate_provider.dart';
import 'package:teams_clone/resources/auth_methods.dart';
import 'package:teams_clone/screens/auth/email_signup_screen.dart';
import 'package:teams_clone/screens/home/home_screen.dart';
import 'package:teams_clone/shared/app_state_builder.dart';
import 'package:teams_clone/utils/utilities.dart';

class EmailLoginScreen extends StatefulWidget {
  @override
  _EmailLoginScreenState createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password;

  AppStateProvider _appStateProvider;

  login() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      _appStateProvider.setToLoading();

      FirebaseUser firebaseUser =
          await AuthMethods.signInWithEmail(_email, _password);

      _appStateProvider.setToIdle();

      if (firebaseUser == null) return;

      Utils.successToast("Welcome Back!");

      Utils.pushAndRemovePrevious(
        context,
        HomeScreen(),
      );
    }
  }

  showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _appStateProvider = Provider.of<AppStateProvider>(context);

    return AppStateBuilder(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                child: Image(
                  image: AssetImage("images/login.png"),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input.trim().isEmpty) return 'Enter Email';
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email)),
                            onSaved: (input) => _email = input),
                      ),
                      Container(
                        child: TextFormField(
                            validator: (input) {
                              if (input.trim().length < 6)
                                return 'Provide Minimum 6 Character';
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input),
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        onPressed: login,
                        child: Text('LOGIN',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                        color: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child: Text('Create an Account?'),
                onTap: () => Utils.navigateTo(context, EmailSignupScreen()),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
