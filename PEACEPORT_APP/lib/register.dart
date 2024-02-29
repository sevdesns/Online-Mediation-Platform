import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/login.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  _RegisterState();

  bool showProgress = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController nameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmpassController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  bool _isObscure = true;
  bool _isObscure2 = true;

  File? file;
  var options = [
    'Citizen',
    'Mediator',
  ];
  var _currentItemSelected = "Citizen";
  var rool = "Citizen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,backgroundColor:  Color.fromARGB(255, 32, 145, 186),),
      backgroundColor: Color.fromARGB(255, 32, 145, 186),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipOval(
              child: Image.asset(
                "assets/image/logo.jpg",
                // Add other properties for the image if needed...
                width: 225,
                height: 125,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Color.fromARGB(255, 32, 145, 186),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          "Register Now",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor:  Color(0xFFB3E5FC),
                            hintText: 'Name',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 8.0,
                              top: 8.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFB3E5FC),
                            hintText: 'Email',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 8.0,
                              top: 8.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.length == 0) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(
                              "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]",
                            ).hasMatch(value)) {
                              return ("Please enter a valid email");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Color(0xFFB3E5FC),
                            hintText: 'Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 8.0,
                              top: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            RegExp regex = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (!regex.hasMatch(value)) {
                              return (
                                  "please enter valid password min. 6 character");
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmpassController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure2
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              },
                            ),
                            filled: true,
                            fillColor:  Color(0xFFB3E5FC),
                            hintText: 'Confirm Password',
                            enabled: true,
                            contentPadding: const EdgeInsets.only(
                              left: 14.0,
                              bottom: 8.0,
                              top: 15.0,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                              borderRadius: new BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (confirmpassController.text !=
                                passwordController.text) {
                              return "Password did not match";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Role : ",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            DropdownButton<String>(
                              dropdownColor:  Color(0xFFB3E5FC),
                              isDense: true,
                              isExpanded: false,
                              iconEnabledColor: Colors.white,
                              focusColor: Colors.white,
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  rool = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(),
                                  ),
                                );
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color:  Color(0xFFB3E5FC),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              elevation: 5.0,
                              height: 40,
                              onPressed: () {
                                setState(() {
                                  showProgress = true;
                                });
                                signUp(
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  confirmpassController.text,
                                  rool,
                                );
                              },
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              color:  Color(0xFFB3E5FC),
                            ),
                          ],
                        ),
                        const SizedBox(
                        height: 70,
                        ),
                        const Text(
                        "'Peace at home, Peace in the world.'",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String name, String email, String password, String confirmPassword, String role) async {
  if (_formkey.currentState!.validate()) {
    if (password == confirmPassword) { 
      try {
        // Display "Signing Up..." message to the user
        showProgressDialog();

        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Create a reference to the user's document in the "users" collection
        DocumentReference userDocRef = FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid);

        // Set the user data in the document
        await userDocRef.set({
          'uid' : _auth.currentUser!.uid,
          'email': email, 
          'name': name,  // Use the provided name
          'bio': 'Empty bio...',  // You can customize the default bio
          'rool': rool,
          // Add any other fields you want to store
        });

        // Close the "Signing Up..." message
        hideProgressDialog();

        // Navigate to LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } catch (e) {
        // Close the "Signing Up..." message
        hideProgressDialog();

        setState(() {
          showProgress = false;
        });

        _showAlertDialog("Error", e.toString());
      }
    } else {
      setState(() {
        showProgress = false;
      });
      _showAlertDialog("Error", "Password did not match");
    }
  }
}


  void showProgressDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Signing Up..."),
            ],
          ),
        );
      },
    );
  }

  void hideProgressDialog() {
    Navigator.pop(context);
  }

  void _showAlertDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}