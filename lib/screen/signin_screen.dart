import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_ui/screen/home_screen.dart';
import 'package:login_ui/screen/signup_screen.dart';
import 'package:login_ui/utils/color_utils.dart';
import '../reusable_widgets/logo_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  TextEditingController _emailTextController = TextEditingController(); 
  TextEditingController _passwordTextController = TextEditingController(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],begin: Alignment.topCenter, end: Alignment.bottomRight
            )
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  logoWidget("assets/images/beelabs.png"),
                  SizedBox(
                    height: 30,
                  ),
                  reusableTextFeild("Enter UserName", Icons.person_outlined, false,
                  _emailTextController),
                   SizedBox(
                    height: 30,
                  ),
                   reusableTextFeild("Enter Password", Icons.lock_outline, true,
                  _passwordTextController),
                  SizedBox(
                    height: 30,
                  ),
                  signInSignUpButton(context, true, (){
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text).then((value) {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                      }).onError((error, stackTrace) {
                        print("Error ${error.toString()}");
                      });
                     
                  }),
                  signUpOption()
                ],
              ),),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have account?",
        style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: ((context) => SignUpScreen())));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}