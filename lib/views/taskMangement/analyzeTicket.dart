import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/views/HomePage/homePage.dart';

class AnalyzeTicketPage extends StatefulWidget {
  const AnalyzeTicketPage({Key? key}) : super(key: key);

  @override
  State<AnalyzeTicketPage> createState() => _AnalyzeTicketPageState();
}

class _AnalyzeTicketPageState extends State<AnalyzeTicketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/appLogo.png',
              color: AppColor.blue,
              height: ScreenSize.height(context) * 0.10,
              width: ScreenSize.width(context) * 0.25,
            ),
            elevation: 5,
            backgroundColor: AppColor.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            leading: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: AppColor.blue,
                )),
          )
      ),
      body: Container(
        height: 50,
        width: 50,
        color: AppColor.primaryColor,
      ),
    );
  }
}
