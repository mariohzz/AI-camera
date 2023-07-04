//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:python_project/auth/auth.dart';
import 'package:python_project/screens/LoginScreen.dart';

import '../dropdownmenu.dart';
import '../userCreate.dart';

class SignupScreen extends StatefulWidget {
  late final UserDatabase userDatabase;
  final Auth userAuth;
  SignupScreen(this.userDatabase, this.userAuth);
  @override
  _SignupScreenState createState() => _SignupScreenState(this.userDatabase, this.userAuth);
}

class _SignupScreenState extends State<SignupScreen> {
  late FocusNode focusNode1;
  late FocusNode focusNode2;
  late FocusNode focusNode3;
  late FocusNode focusNode4;
  late FocusNode focusNode5;
  final UserDatabase userDatabase;
  final Auth userAuth;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  late String _name;
  late String _city;
  String _selectedOption = '';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerCity = TextEditingController();
  final TextEditingController _controllerChoice = TextEditingController();
  static const List<String> list = <String>['clalit', 'maccabi', 'meuhedet'];
  String selectedValue = list.first;

  _SignupScreenState(this.userDatabase, this.userAuth);

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await userAuth.createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      await userDatabase.createUser(
        _controllerEmail.text,
        _controllerPassword.text,
        _controllerName.text,
        _controllerCity.text,
        selectedValue,
      );

      // Signup successful, show dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Signup Successful'),
            content: Text('Congratulations! Your account has been created.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen(widget.userDatabase, widget.userAuth)),
                  );
                },
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Widget _entryField(String title, TextEditingController controller, {bool isPassword = false}) {
    return TextFormField(
      onSaved: (value) {
        controller.text = value!;
      },
      controller: controller,
      keyboardType: TextInputType.text,
      style: const TextStyle(fontSize: 16, color: Colors.black),
      obscureText: isPassword, // Set obscureText to true for password field
      decoration: InputDecoration(
        labelText: title,
        contentPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.022, horizontal: 15.0),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
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
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  bool isLogin = true;
  String? errorMessage = '';

  @override
  void initState() {
    super.initState();

    focusNode1 = FocusNode();
    focusNode2 = FocusNode();
    focusNode3 = FocusNode();
    focusNode4 = FocusNode();
    focusNode5 = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
              ),
              Container(
                height: 150,
                child: const Image(
                  image: AssetImage("images/baby1.png"),
                  fit: BoxFit.contain,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          _entryField("Email", _controllerEmail),
                          SizedBox(height: 16.0),
                          _entryField("Password", _controllerPassword,isPassword:true),
                          SizedBox(height: 16.0),
                          _entryField("Name", _controllerName),
                          SizedBox(height: 16.0),
                          _entryField("City", _controllerCity),
                          SizedBox(height: 16.0),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              border: Border.all(color: Colors.grey.shade400),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedValue,
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 30,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                                items: list.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(fontSize: 16, color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: 200.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            createUserWithEmailAndPassword();
                          }
                        },
                        child: Text(
                          isLogin ? 'Signup' : 'Register',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              if (errorMessage != null && errorMessage!.isNotEmpty)
                Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(height: 16.0),
             //_logOrReg(),
            ],
          ),
        ),
      ),
    );
  }
}
