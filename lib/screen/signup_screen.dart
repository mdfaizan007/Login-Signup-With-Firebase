
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/reusable_widgets/logo_widgets.dart';
import '../utils/color_utils.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController _userNameTextController = TextEditingController(); 
  TextEditingController _emailTextController = TextEditingController(); 
  TextEditingController _passwordTextController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign Up",
          style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
          ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
             hexStringToColor("CB2B93"),
            hexStringToColor("9546C4"),
            hexStringToColor("5E61F4"),
          ],begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20,100,20,0),
                child: Column(
                  children:  <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextFeild("Enter UserName", Icons.person_outline, false,
                     _userNameTextController),
                     const SizedBox(
                      height: 20,
                    ),
                    reusableTextFeild("Enter EmailId", Icons.person_outline, false,
                     _emailTextController),
                      const SizedBox(
                      height: 20,
                    ),
                    reusableTextFeild("Enter Password", Icons.lock_outlined, true,
                     _passwordTextController),
                     const SizedBox(
                      height: 20,
                    ),
                    signInSignUpButton(context, false, (){
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: _emailTextController.text,
                       password: _passwordTextController.text)
                       .then((value) {
                        print("Created New Account");
                         Navigator.push(context, 
                         MaterialPageRoute(builder: (context) => HomeScreen()));
                       }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                       });
                     
                    })
                  ],
                ),
                ),
          ),
      ),
    );
  }
}