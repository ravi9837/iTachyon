import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/appConst.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/controllers/appController.dart';
import 'package:itachyon/views/joinNow/joinFour.dart';
import 'package:itachyon/views/joinNow/joinSecond.dart';

class JoinNowThree extends StatefulWidget {

  const JoinNowThree({Key? key,
    required this.fName,
    required this.lName,
    required this.phoneNum,
    required this.emailAdd})
      : super(key: key);
  final String fName;
  final String lName;
  final String phoneNum;
  final String emailAdd;

  @override
  State<JoinNowThree> createState() => _JoinNowThreeState();
}

class _JoinNowThreeState extends State<JoinNowThree> {
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
                  SizedBox(width: ScreenSize.width(context) * 0.45,),
                  TextButton(onPressed: (){
                    password.clear();
                    confirmPassword.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => JoinNowSecond(fName: widget.fName, lName: widget.lName,)),
                    );
                  },
                      child: Text("Back",
                    style: TextStyle(
                        color: AppColor.blue, fontWeight: FontWeight.w600),)),
                ],
              ),
              SizedBox(height: ScreenSize.height(context) * 0.020,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("SET PASSWORD",
                  style: TextStyle(
                      color: AppColor.black, fontWeight: FontWeight.w600,fontSize: 20),
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.050,),
              TextFormField(
                controller: password,
                obscureText: passwordVisible,
                decoration: InputDecoration(

                    suffixIcon: IconButton(
                      color: passwordVisible ? AppColor.grey: AppColor.blue,
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(
                              () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                  hintText: "PASSWORD*",
                  hintStyle: TextStyle(color: AppColor.black),
                  labelStyle: TextStyle(color: AppColor.black),
                  labelText: "PASSWORD*",
                  errorText: passwordValidate ? 'Password length should be greater then 6 characters':null,
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.050,),
              TextFormField(
                controller: confirmPassword,
                obscureText: conPasswordVisible,
                decoration: InputDecoration(
                  hintText: "CONFIRM PASSWORD*",
                  hintStyle: TextStyle(color: AppColor.black),
                  labelStyle: TextStyle(color: AppColor.black),
                  labelText: "CONFIRM PASSWORD*",
                  errorText: confirmPasswordValidate ? "Password not matched" : null,
                  suffixIcon: IconButton(
                    color: conPasswordVisible ? AppColor.grey: AppColor.blue,

                    icon: Icon(conPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(
                            () {
                              conPasswordVisible = !conPasswordVisible;
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: ScreenSize.height(context)*0.030 ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Password should be more then 6 characters',
                  style: TextStyle(
                      color: AppColor.black, fontWeight: FontWeight.w400,fontSize: 10),),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.090,),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (password.text.isEmpty || password.text.length < 6) {
                      passwordValidate =true;
                    }
                    else if (confirmPassword.text != password.text) {
                      confirmPasswordValidate = true;
                    }
                    else {
                      // Navigate to the next screen
                      passwordValidate = false;
                      confirmPasswordValidate = false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JoinNowFour(
                            fName: widget.fName,
                            lName : widget.lName,
                            phoneNum : widget.phoneNum,
                            emailAdd : widget.emailAdd,
                            password: password.text,
                        )
                        ),
                      );
                    }
                  });
                },
                child: Container(
                    height: ScreenSize.height(context) * 0.070,
                    width: ScreenSize.width(context) * 0.90,
                    decoration: BoxDecoration(
                        color: AppColor.blue,
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        "Continue",
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
