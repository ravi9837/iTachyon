import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/appConst.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/controllers/appController.dart';
import 'package:itachyon/services/methods.dart';
import 'package:itachyon/services/firebaseServices.dart' as fs;
import 'package:itachyon/views/joinNow/joinFirst.dart';
import 'package:itachyon/views/joinNow/joinThree.dart';


class JoinNowSecond extends StatefulWidget {

  const JoinNowSecond({Key? key,
    required this.fName,
    required this.lName })
      : super(key: key);
  final String fName;
  final String lName;


  @override
  State<JoinNowSecond> createState() => _JoinNowSecondState();
}

class _JoinNowSecondState extends State<JoinNowSecond> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top:30,bottom: 20,left:20,right: 10),
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
                    phone.clear();
                    email.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => JoinNowFirst()),
                    );
                  }, child: Text("Back",
                    style: TextStyle(
                        color: AppColor.blue, fontWeight: FontWeight.w600),)),
                ],
              ),
              SizedBox(height: ScreenSize.height(context) * 0.020,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("ADD YOUR PHONE AND EMAIL",
                  style: TextStyle(
                      color: AppColor.black, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.050,),
              TextFormField(
                controller: phone,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "PHONE*",
                  hintStyle: TextStyle(color: AppColor.black),
                  labelStyle: TextStyle(color: AppColor.black),
                  labelText: "PHONE*",
                  errorText: phoneValidate
                      ? 'Please enter a 10-digit phone number'
                      : null,
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.050,),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  hintText: "EMAIL*",
                  hintStyle: TextStyle(color: AppColor.black),
                  labelStyle: TextStyle(color: AppColor.black),
                  labelText: "EMAIL*",
                  errorText: emailValidate
                      ? 'Please enter a valid email address'
                      : null,
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.090,),
              GestureDetector(
                onTap: () async{
                  // await fs.AuthService.checkIfUserIsRegistered(email: email.text);
                  setState(() {
                    if (phone.text.isEmpty || phone.text.length != 10) {
                      phoneValidate =true;
                    }else if ( !isValidEmail(email.text) || email.text.isEmpty) {
                      emailValidate = true;
                    } else {
                      // Navigate to the next screen
                      phoneValidate = false;
                      emailValidate = false;

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  JoinNowThree(
                            fName: widget.fName,
                            lName : widget.lName,
                            phoneNum : phone.text,
                            emailAdd : email.text)),
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
