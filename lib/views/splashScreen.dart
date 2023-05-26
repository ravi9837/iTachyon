import 'package:flutter/material.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/views/auth/joinAndSigninScreen.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextPage();
  }

  void navigateToNextPage() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => JoinAndSigninScreen()), // Replace 'NextPage' with your actual page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColor.white,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: Expanded(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        height: ScreenSize.height(context) * 0.25,
                      ),
                      SizedBox(height: 80,),
                      Shimmer.fromColors(
                        baseColor: AppColor.blue,
                        highlightColor: AppColor.white,
                        child: Image.asset(
                          'assets/appLogo.png',
                          height: ScreenSize.height(context) * 0.10,
                          width: ScreenSize.width(context) * 0.55,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: 50,),
                      Container(
                        child: Text(
                          '''JOIN A TRUSTED COMMUNITY OF
          HEALTHCARE WORKERS''',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
