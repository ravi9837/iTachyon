import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/views/HomePage/homePage.dart';

class TicketReportPage extends StatefulWidget {
  const TicketReportPage({Key? key}) : super(key: key);

  @override
  State<TicketReportPage> createState() => _TicketReportPageState();
}

class _TicketReportPageState extends State<TicketReportPage> {
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
          )),
      body:ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 5,
              child: ListTile(
                  leading: const Icon(Icons.list),
                  trailing: const Text(
                    "GFG",
                    style: TextStyle(color: Colors.green, fontSize: 15),
                  ),
                  title: Text("List item $index")),
            );
          }),
    );
  }
}
