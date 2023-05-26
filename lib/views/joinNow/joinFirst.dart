import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/controllers/appController.dart';
import 'package:itachyon/views/auth/joinAndSigninScreen.dart';
import 'package:itachyon/views/joinNow/joinSecond.dart';
import '../../const/screenSize.dart';
import 'package:itachyon/const/appConst.dart';

class JoinNowFirst extends StatefulWidget {
  const JoinNowFirst({super.key});

  @override
  State<JoinNowFirst> createState() => _JoinNowFirstState();
}

class _JoinNowFirstState extends State<JoinNowFirst> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 20, left: 20, right: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/appLogo.png',
                    color: AppColor.blue,
                    height: ScreenSize.height(context) * 0.10,
                    width: ScreenSize.width(context) * 0.30,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(
                    width: ScreenSize.width(context) * 0.45,
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          firstName.clear();
                          lastName.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const JoinAndSigninScreen()),
                          );
                        });
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(
                            color: AppColor.blue, fontWeight: FontWeight.w600),
                      )),
                ],
              ),
              SizedBox(
                height: ScreenSize.height(context) * 0.020,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "ADD YOUR NAME",
                  style: TextStyle(
                      color: AppColor.black, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: ScreenSize.height(context) * 0.050,
              ),
              TextFormField(
                controller: firstName,
                decoration: InputDecoration(
                  hintText: "First Name*",
                  hintStyle: TextStyle(color: AppColor.black),
                  labelStyle: TextStyle(color: AppColor.black),
                  labelText: "First Name*",
                  errorText: firstNameValidate ? 'Value Can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: ScreenSize.height(context) * 0.050,
              ),
              TextFormField(
                controller: lastName,
                decoration: InputDecoration(
                  hintText: "Last Name*",
                  hintStyle: TextStyle(color: AppColor.black),
                  labelStyle: TextStyle(color: AppColor.black),
                  labelText: "Last Name*",
                  errorText: lastNameValidate ? 'Value Can\'t Be Empty' : null,
                ),
              ),
              SizedBox(
                height: ScreenSize.height(context) * 0.090,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (firstName.text.isEmpty ) {
                      // Show error message
                      firstNameValidate = true;
                    }else if(lastName.text.isEmpty){
                      lastNameValidate=true;
                    } else {
                      // Navigate to the next screen
                      firstNameValidate = false;
                      lastNameValidate= false;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  JoinNowSecond(fName : firstName.text , lName: lastName.text)),
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
                    child: const Center(
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
