import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:teams_clone/constants/strings.dart';
import 'package:teams_clone/models/user.dart';
import 'package:teams_clone/provider/appstate_provider.dart';
import 'package:teams_clone/resources/auth_methods.dart';
import 'package:teams_clone/screens/home/home_screen.dart';
import 'package:teams_clone/shared/app_state_builder.dart';
import 'package:teams_clone/utils/utilities.dart';

class EmailSignupScreen extends StatefulWidget {
  @override
  _EmailSignupScreenState createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name, _email, _password;

  AppStateProvider _appStateProvider;

  performSignupWithEmail() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _appStateProvider.setToLoading();

    _formKey.currentState.save();

    FirebaseUser firebaseUser =
        await AuthMethods.signUpWithEmail(_email, _password);

    _appStateProvider.setToIdle();

    if (firebaseUser == null) return;

    AuthMethods.addDataToDb(firebaseUser);

    User user = User(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        name: _name,
        profilePhoto: demoImage,
        state: 1,
        status: "",
        username: Utils.getUsername(firebaseUser.email));

    AuthMethods.addLocalUserToDb(user);

    Utils.successToast("Sign Up Successful");

    Utils.pushAndRemovePrevious(
      context,
      HomeScreen(),
    );
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
                              if (input.trim().isEmpty)
                                return 'Enter Full Name';
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            onSaved: (input) => _name = input),
                      ),
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
                        onPressed: () => performSignupWithEmail(),
                        child: Text('SignUp',
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
            ],
          ),
        ),
      )),
    );
  }
}
