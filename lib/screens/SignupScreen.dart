import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:python_project/auth/auth.dart';

import '../userCreate.dart';

class SignupScreen extends StatefulWidget {
  late final UserDatabase userDatabase;
  SignupScreen(this.userDatabase);
  @override
  _SignupScreenState createState() => _SignupScreenState(this.userDatabase);
}

class _SignupScreenState extends State<SignupScreen> {
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  final UserDatabase userDatabase;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
    final TextEditingController _controllerEmail =TextEditingController();
  final TextEditingController _controllerPassword =TextEditingController();

  _SignupScreenState(this.userDatabase);

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
      await userDatabase.createUser(_controllerEmail.text, _controllerPassword.text);
      print('User created successfully!');
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
   Widget _entryField(String Title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText:  
        Title,
      ),
    );
  }
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
  String? errorMessage = '';
  @override
  void initState() {
    super.initState();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: <Widget>[
                ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.deepPurple[300],
                  ),
                  clipper: RoundedClipper(60),
                ),
                ClipPath(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.18,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.deepPurpleAccent,
                  ),
                  clipper: RoundedClipper(50),
                ),
                Positioned(
                    top: -50,
                    left: -30,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.15) / 2),
                          color: Colors.deepPurple[300]?.withOpacity(0.3)),
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurpleAccent),
                        ),
                      ),
                    )),
                Positioned(
                    top: -50,
                    left: MediaQuery.of(context).size.width * 0.6,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.height * 0.20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.20) / 2),
                          color: Colors.deepPurple[300]?.withOpacity(0.3)),
                      child: Center(
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.deepPurpleAccent),
                        ),
                      ),
                    )),
                Positioned(
                    top: -50,
                    left: 80,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              (MediaQuery.of(context).size.height * 0.15) / 2),
                          color: Colors.deepPurple[300]?.withOpacity(0.3)),
                    )),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15 - 50),
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height * 0.80) - 22,
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
                    focusNode: focusNode1,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Email",
                      contentPadding:  EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(focusNode2);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    onSaved: (var val) {
                      _controllerPassword.text = val!;
                    },
                    focusNode: focusNode2,
                    obscureText: true,
                    controller: _controllerPassword,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Password",
                      contentPadding:  EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                    onFieldSubmitted: (String value) {
                      FocusScope.of(context).requestFocus(focusNode3);
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  
                  TextFormField(
                    onSaved: (val) {
                      _password = val!;
                    },
                    focusNode: focusNode3,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.022,
                          horizontal: 15.0),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                      onTap: () {
                        createUserWithEmailAndPassword();
                        _entryField('email', _controllerEmail);
                          _entryField('Password', _controllerPassword);
                          _logOrReg();
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.065,
                        decoration: const BoxDecoration(
                            color: Colors.deepPurpleAccent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: const Center(
                          child: Text(
                            "SIGN UP",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                      onTap: () {
                        print("pressed");
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          decoration: const BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              shape: BoxShape.circle),
                          child:
                              const Icon(Icons.arrow_back, color: Colors.white))),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  bool _value1 = false;
 late bool _autoValidate = false;

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



  String? validatePassword(String value) {
    if (value.length < 6)
      return 'Password must be atleast 6 digits';
    else {
      return null;
    }
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
