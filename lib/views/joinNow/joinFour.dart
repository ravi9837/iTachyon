import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/appConst.dart';
import 'package:itachyon/controllers/appController.dart';
import 'package:itachyon/services/firebaseServices.dart' as fs;
import 'package:itachyon/views/HomePage/homePage.dart';
import 'package:itachyon/views/joinNow/joinThree.dart';
import '../../const/screenSize.dart';

class JoinNowFour extends StatefulWidget {
  const JoinNowFour({Key? key,
    required this.password,
    required this.emailAdd,
    required this.phoneNum,
    required this.lName,
    required this.fName}) : super(key: key);

  final String fName;
  final String lName;
  final String phoneNum;
  final String emailAdd;
  final String password;

  @override
  State<JoinNowFour> createState() => _JoinNowFourState();
}



class _JoinNowFourState extends State<JoinNowFour> {
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => JoinNowThree(
                        fName: widget.fName,
                        lName: widget.lName,
                        phoneNum: widget.phoneNum,
                        emailAdd: widget.emailAdd,)),
                    );
                  }, child: Text("Back",
                    style: TextStyle(
                        color: AppColor.blue, fontWeight: FontWeight.w600),)),
                ],
              ),
              SizedBox(height: ScreenSize.height(context) * 0.020,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("ENTER CLINIC DETAILS",
                  style: TextStyle(
                      color: AppColor.black, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.050,),
              TextFormField(
                controller: clinic,
                decoration: InputDecoration(
                  hintText: "CLINIC CODE*",
                  hintStyle: TextStyle(color: AppColor.black),
                  labelStyle: TextStyle(color: AppColor.black),
                  labelText: "CLINIC CODE*",
                ),
              ),
              SizedBox(height: 5,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Axiphyl Clinic",
                  style: TextStyle(
                    color: clinic.text == clinic_code ? AppColor.green : AppColor.white,

                  ),
                ),
              ),
              SizedBox(height: ScreenSize.height(context) * 0.010,),
              Padding(
                padding: EdgeInsets.only(left: 30,bottom: 10),
                child: CheckboxListTile( //checkbox positioned at left
                  value: clinicTerms,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? value) {
                    setState(() {
                      clinicTerms = false;
                      clinicTerms = value!;
                    });
                  },
                  title: Text("Agree to termas and policy"),
                ),
              ),
              Text('''By clicking Agree & Join, you agree to all the Agreements
  done by the company, Privacy policy and Cookies Policy.'''),
              SizedBox(height: ScreenSize.height(context) * 0.090,),
              GestureDetector(
                onTap: ()async{
                  await fs.AuthService.registerUsingEmailPassword(
                      name: widget.fName,
                      email: widget.emailAdd,
                      password: widget.password);
                  await fs.AuthService.setProfile(
                      fName: widget.fName,
                      lName: widget.lName,
                      phone: widget.phoneNum,
                      email: widget.emailAdd,
                      password: widget.password);
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
                    child: Center(
                      child: Text(
                        "Agree & Join",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
