import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:python_project/auth/auth.dart';
import 'package:python_project/screens/SignupScreen.dart';

import '../navigation.dart';
import '../userCreate.dart';
import '../widgets/logo.dart';

class LoginScreen extends StatefulWidget {
  late final UserDatabase userDatabase;
  LoginScreen(this.userDatabase);
  @override
  _LoginScreenState createState() => _LoginScreenState(userDatabase);
}

class _LoginScreenState extends State<LoginScreen> {
  late final UserDatabase userDatabase;
  late FocusNode myFocusNode;
  _LoginScreenState(this.userDatabase);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      // Navigate to the Material3BottomNav page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Material3BottomNav(userDatabase,0)),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _title() {
    return const Text('Firebase Auth');
  }

    Widget _entryField(String Title, TextEditingController controller) {
      return TextField(
        controller: controller,
      );
    }

  Widget _errorMessage() {
    return Center(child: Text(errorMessage == '' ? '' : 'humm ? $errorMessage'));
  }
/*
  Widget _logOrReg() {
    return TextButton(
        onPressed: () {
          setState(() {
            isLogin = !isLogin;
          });
        },
        child: Text(isLogin ?'Register instead':'Login instead'));
  }

  bool isLogin = true;
  */
  String? errorMessage = '';

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    myFocusNode.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Stack(
              children: [
                Container(
                  width: 250,
                  height: 250,
                  child: Image.asset(
                    'images/baby1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 90,
                  right: 0,
                  child: AnimatedText("Baby Care"),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.fromLTRB(20, 12, 20, 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        onSaved: (val) {
                          _controllerEmail.text = val!;
                        },
                        controller: _controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: "Email",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.022,
                            horizontal: 15.0,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                        ),
                        onFieldSubmitted: (String value) {
                          FocusScope.of(context).requestFocus(myFocusNode);
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onSaved: (val) {
                          _controllerPassword.text = val!;
                        },
                        controller: _controllerPassword,
                        focusNode: myFocusNode,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          labelText: "Password",
                          contentPadding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.022,
                            horizontal: 15.0,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: const <Widget>[
                            /*
                          Checkbox(
                            activeColor: Colors.deepPurpleAccent,
                            value: _value1,
                            // onChanged: _value1Changed,
                          ),
                          */
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Container(
                        child: ElevatedButton(
                          onPressed: () {
                            signWithEmailAndPassword();
                            _entryField('email', _controllerEmail);
                            _entryField('Password', _controllerPassword);
                            // _logOrReg();
                          },
                          child: Container(
                            child: const Center(
                              child: Text(
                                "SIGN IN",
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _errorMessage(),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 15),
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: GestureDetector(
                          onTap: () {
                            print("signup");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignupScreen(userDatabase)),
                            );
                          },
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Text(
                                  "New User?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Signup",
                                  style: TextStyle(
                                    color: Colors.deepPurpleAccent,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  bool _value1 = false;
  bool _autoValidate = false;

  void _value1Changed(bool value) => setState(() => _value1 = value);

  void _validateInputs() {
    if (_formKey.currentState!.validate()) {
//    If all data are correct then save data to out variables
      _formKey.currentState!.save();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }


   validatePassword(String value) {
    if (value.length < 6)
      return 'Password must be atleast 6 digits';
    else
      return null;
  }
}

class RoundedClipper extends CustomClipper<Path> {
  var differenceInHeights = 0;

  RoundedClipper(int differenceInHeights) {
    this.differenceInHeights = differenceInHeights;
  }

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - differenceInHeights);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
