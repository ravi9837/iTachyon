import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/controllers/appController.dart';
import 'package:itachyon/views/HomePage/homePage.dart';
import 'package:itachyon/services/firebaseServices.dart' as fs;


class CreateTicketPage extends StatefulWidget {
  const CreateTicketPage({Key? key,required this.email}) : super(key: key);
final String email;
  @override
  State<CreateTicketPage> createState() => _CreateTicketPageState();
}

class _CreateTicketPageState extends State<CreateTicketPage> {
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
                )
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: ScreenSize.height(context) * 0.02,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Create Ticket",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  )),
              SizedBox(
                height: ScreenSize.height(context) * 0.050,
              ),
              TextFormField(
                controller: createTitle,
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(color: AppColor.black),
                  labelStyle: TextStyle(color: AppColor.black),
                  labelText: "Title",
                ),
              ),
              SizedBox(
                height: ScreenSize.height(context) * 0.050,
              ),
              TextFormField(
                controller: createDescription,
                decoration: InputDecoration(
                  hintText: "Description",
                  hintStyle: TextStyle(color: AppColor.black),
                  labelStyle: TextStyle(color: AppColor.black),
                  labelText: "Description",
                ),
              ),
              SizedBox(
                height: ScreenSize.height(context) * 0.10,
              ),
              GestureDetector(
                onTap: () async{
                  await fs.AuthService.setTicket(
                      title: createTitle.text,
                      description: createDescription.text,
                      email: widget.email);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()), // Replace 'NextPage' with your actual page
                  );
                },
                child: Container(
                    height: ScreenSize.height(context) * 0.070,
                    width: ScreenSize.width(context) * 0.90,
                    decoration: BoxDecoration(
                        color: AppColor.blue,
                        borderRadius: BorderRadius.circular(50)),
                    child: const Center(
                      child: Text(
                        "Create",
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
