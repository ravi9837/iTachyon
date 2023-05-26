import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/views/joinNow/joinFirst.dart';
import 'package:itachyon/views/signIn/signIn.dart';

class JoinAndSigninScreen extends StatefulWidget {
  const JoinAndSigninScreen({Key? key}) : super(key: key);

  @override
  State<JoinAndSigninScreen> createState() => _JoinAndSigninScreenState();
}

class _JoinAndSigninScreenState extends State<JoinAndSigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: ScreenSize.height(context) * 0.15,
            ),
            Image.asset(
              'assets/appLogo.png',
              color: AppColor.blue,
              height: ScreenSize.height(context) * 0.10,
              width: ScreenSize.width(context) * 0.55,
              fit: BoxFit.fitWidth,
            ),
            Container(
              height: ScreenSize.height(context) * 0.15,
            ),
            Container(
              child: Text('''JOIN A TRUSTED COMMUNITY OF
           HEALTHCARE WORKERS'''),
            ),
            Container(
              height: ScreenSize.height(context) * 0.25,
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => JoinNowFirst()), // Replace 'NextPage' with your actual page
                );
              },
              child: Container(
                  height: ScreenSize.height(context) * 0.070,
                  width: ScreenSize.width(context) * 0.90,
                  decoration: BoxDecoration(
                      color: AppColor.blue,
                      borderRadius: BorderRadius.circular(50)),
                  child: Center(
                    child: Text(
                      "Join Now",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
            SizedBox(
              height: ScreenSize.height(context) * 0.01,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()), // Replace 'NextPage' with your actual page
                );
              },
              child: Text(
                "Sign in",
                style: TextStyle(
                    color: AppColor.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}
