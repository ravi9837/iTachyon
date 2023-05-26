import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/appConst.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/controllers/appController.dart';
import 'package:itachyon/services/methods.dart';
import 'package:itachyon/services/toastMessage.dart';
import 'package:itachyon/views/HomePage/homePage.dart';
import 'package:itachyon/views/auth/joinAndSigninScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}
final FirebaseAuth _auth = FirebaseAuth.instance;




class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:30,bottom: 20,left:20,right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/appLogo.png',
                    color: AppColor.blue,
                    height: ScreenSize.height(context) * 0.10,
                    width: ScreenSize.width(context) * 0.30,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(width: ScreenSize.width(context) * 0.40,),
                  TextButton(onPressed: (){
                    emailValidate=false;
                    signInPasswordValidate=false;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => JoinAndSigninScreen()),
                    );
                  },
                      child: Text("Join now",
                    style: TextStyle(
                        color: AppColor.blue, fontWeight: FontWeight.w600),)),
                ],
              ),
              SizedBox(height: ScreenSize.height(context) * 0.020,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Sign in",
                  style: TextStyle(
                      color: AppColor.black, fontWeight: FontWeight.w400,fontSize: 25),
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.050,),
              TextFormField(
                controller: signInEmail,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email,color: AppColor.blue,),
                  hintText: "Email",
                  hintStyle: TextStyle(color: AppColor.black),
                  errorText:emailValidate
                      ? 'Please enter a valid email address'
                      : null,
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.050,),
              TextFormField(
                controller: signInPassword,
                obscureText: signInPasswordVisible,
                decoration: InputDecoration(
                  hintText: "PASSWORD*",
                  prefixIcon: Icon(Icons.key,color: AppColor.blue,),
                  hintStyle: TextStyle(color: AppColor.black),
                  errorText: signInPasswordValidate ? "Please enter a valid password":null,
                  suffixIcon: IconButton(
                    color: signInPasswordVisible ? AppColor.grey: AppColor.blue,

                    icon: Icon(signInPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(
                            () {
                              signInPasswordVisible = !signInPasswordVisible;
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: ScreenSize.height(context)*0.010 ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: (){},
                  child: Text('Forgot Password ?',
                    style: TextStyle(
                        color: AppColor.blue, fontWeight: FontWeight.w400,fontSize: 15),),
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.090,),
              GestureDetector(
                onTap: () async {
                  if (!isValidEmail(signInEmail.text) || signInEmail.text.isEmpty) {
                    setState(() {
                      emailValidate = true;
                    });
                    return;
                  }  else if (signInPassword.text.isEmpty) {
                    signInPasswordValidate = true;
                  }

                  try {
                    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                      email: signInEmail.text,
                      password: signInPassword.text,
                    );

                    if (userCredential.user != null) {
                      // User is authenticated, navigate to the homepage
                      showToast('loged in successfully', ToastGravity.BOTTOM);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      // Invalid user
                      showToast('Invalid user',ToastGravity.BOTTOM); // Replace with your toast implementation
                    }
                  } catch (e) {
                    print('Sign in failed: $e');
                    showToast('Sign in failed',ToastGravity.BOTTOM); // Replace with your toast implementation
                  }
                },
                child: Container(
                    height: ScreenSize.height(context) * 0.070,
                    width: ScreenSize.width(context) * 0.90,
                    decoration: BoxDecoration(
                        color: AppColor.blue,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
