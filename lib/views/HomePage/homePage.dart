import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/services/toastMessage.dart';
import 'package:itachyon/views/taskMangement/analyzeTicket.dart';
import 'package:itachyon/views/taskMangement/createTicket.dart';
import 'package:itachyon/views/taskMangement/manageTicket.dart';
import 'package:itachyon/views/taskMangement/ticketReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:itachyon/widgets/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Add a GlobalKey

  late Map<String, dynamic> userData;

  @override
  initState()  {
    getUserDocument();
    getUserDetails();
    super.initState();

  }
  Future<Map<String, dynamic>> getUserDetails() async {
    DocumentSnapshot<Map<String, dynamic>>? userDocument =
    await getUserDocument();

    if (userDocument != null) {
      // Access the user data from the document
      userData = userDocument.data()!;
      // String name = userData['firstname'];
      // String email = userData['email'];
      // Access other fields similarly

      // Use the user data as needed
      // print('Name: $name');
      // print('Age: $email');
      // Print/access other fields similarly
    }
    return userData;
  }


  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserDocument() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String email = currentUser.email!;
      DocumentReference<Map<String, dynamic>> userDocRef =
      FirebaseFirestore.instance.collection('users').doc(email);

      try {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await userDocRef.get();
        if (userSnapshot.exists) {
          return userSnapshot;

        } else {
          print('Document does not exist for the current user');
        }
      } catch (e) {
        print('Error retrieving user document: $e');
      }
    } else {
      print('User is not signed in');
    }
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
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
            backgroundColor: AppColor.white,
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer(); // Open the drawer
              },
              icon: Icon(
                Icons.person_pin,
                color: AppColor.blue,
              ),
            ),
            actions: [
              GestureDetector(onTap: (){showToast(
                  "coming soon",
                  ToastGravity.BOTTOM);},
          child: const Icon(Icons.search, color: AppColor.blue,)),
              SizedBox(width: ScreenSize.width(context) * 0.05,),
              GestureDetector(onTap:(){
                showToast(
                    "coming soon",
                    ToastGravity.BOTTOM);
              },child: Icon(Icons.chat, color: AppColor.blue,)),
              SizedBox(width: ScreenSize.width(context) * 0.05,),
            ],
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
        ),
        drawer: Drawer( // Add a Drawer widget
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: AppColor.blue,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: 45,
                        child: Icon(Icons.person,size: 80,)
                    ),
                    Text('Name : ${userData["firstname"]}',style: TextStyle(color: AppColor.white),),
                    Text("Email : ${userData['email']}",style: TextStyle(color: AppColor.white),)
                  ],
                )
              ),
              ListTile(
                leading: Icon(Icons.local_hospital),
                title: Text("Axiphyl Clinic"),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Perform the desired action for Item 1
                },
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text("12345"),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  // Perform the desired action for Item 2
                },
              ),
              GestureDetector(
                onTap: (){},
                child: Container(
                  color: Colors.blueGrey.shade200,
                  child: ListTile(
                    leading: Icon(Icons.login_outlined),
                    title: Text("Sign out"),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      // Perform the desired action for Item 2
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: [
                Image.asset('assets/bannerOne.png'),
                Image.asset('assets/bannerTwo.png'),
                Image.asset('assets/bannerThree.png'),
              ],
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.1,
                viewportFraction: 0.97,
                onPageChanged: (index, reason) {
                },
              ),
            ),
            CustomCard(
              elevation: 10,
              borderRadius: 20,
              containerHeight: ScreenSize.height(context) * 0.16,
              containerWidth: ScreenSize.width(context) * 0.95,
              title: "iTachyon Ticket System",
              actions: [
                SizedBox(width: ScreenSize.width(context) * 0.02),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateTicketPage(email: userData['email'],)), // Replace 'NextPage' with your actual page
                    );
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: ScreenSize.height(context) * 0.10,
                      width: ScreenSize.width(context) * 0.20,
                      child: Column(
                        children: [
                          Icon(Icons.add_task, size: 40, color: AppColor.blue),
                          Text('create'),
                          Text('Tickets'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ScreenSize.width(context) * 0.01),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ManageTicketPage()), // Replace 'NextPage' with your actual page
                    );
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: ScreenSize.height(context) * 0.10,
                      width: ScreenSize.width(context) * 0.20,
                      child: Column(
                        children: [
                          Icon(Icons.shield_moon_sharp, size: 40, color: AppColor.blue),
                          Text('Manage'),
                          Text('Tickets'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ScreenSize.width(context) * 0.01),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnalyzeTicketPage()), // Replace 'NextPage' with your actual page
                    );
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: ScreenSize.height(context) * 0.10,
                      width: ScreenSize.width(context) * 0.20,
                      child: Column(
                        children: [
                          Icon(Icons.analytics_outlined, size: 40, color: AppColor.blue),
                          Text('Analyze'),
                          Text('Tickets'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ScreenSize.width(context) * 0.01),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TicketReportPage()), // Replace 'NextPage' with your actual page
                    );
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: ScreenSize.height(context) * 0.10,
                      width: ScreenSize.width(context) * 0.20,
                      child: Column(
                        children: const [
                          Icon(Icons.task, size: 40, color: AppColor.blue),
                          Text('Ticket'),
                          Text('Reports'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              title_2: "iTachyon is always ready to help", bottomColor: Colors.blueGrey.shade100,
            ),
            SizedBox(height: ScreenSize.height(context) * 0.01,),
            CustomCard(
              elevation: 10,
              borderRadius: 20,
              containerHeight: ScreenSize.height(context) * 0.16,
              containerWidth: ScreenSize.width(context) * 0.95,
              title: "iTachyon Communication",
              actions: [
                SizedBox(width: ScreenSize.width(context) * 0.02),
                GestureDetector(
                  onTap: () {
                    showToast(
                        "coming soon",
                        ToastGravity.BOTTOM);
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: ScreenSize.height(context) * 0.10,
                      width: ScreenSize.width(context) * 0.20,
                      child: Column(
                        children: [
                          SizedBox(height:ScreenSize.height(context) * 0.01),
                          Icon(Icons.chat, size: 40, color:Colors.blueGrey.shade200 ),
                          SizedBox(height:ScreenSize.height(context) * 0.01),
                          Text('Chats'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ScreenSize.width(context) * 0.01),
                GestureDetector(
                  onTap: () {
                    showToast(
                        "coming soon",
                        ToastGravity.BOTTOM);
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: ScreenSize.height(context) * 0.10,
                      width: ScreenSize.width(context) * 0.20,
                      child: Column(
                        children: [
                          SizedBox(height:ScreenSize.height(context) * 0.01),
                          Icon(Icons.video_call, size: 40, color:Colors.blueGrey.shade200 ),
                          SizedBox(height:ScreenSize.height(context) * 0.01),
                          Text('Meet'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ScreenSize.width(context) * 0.01),
                GestureDetector(
                  onTap: () {
                    showToast(
                        "coming soon",
                        ToastGravity.BOTTOM);
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: ScreenSize.height(context) * 0.10,
                      width: ScreenSize.width(context) * 0.20,
                      child: Column(
                        children: [
                          SizedBox(height:ScreenSize.height(context) * 0.01),
                          Icon(Icons.email, size: 40, color:Colors.blueGrey.shade200 ),
                          SizedBox(height:ScreenSize.height(context) * 0.01),
                          Text('Email'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ScreenSize.width(context) * 0.01),
                GestureDetector(
                  onTap: () {
                    showToast(
                        "coming soon",
                        ToastGravity.BOTTOM);
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: ScreenSize.height(context) * 0.10,
                      width: ScreenSize.width(context) * 0.20,
                      child: Column(
                        children: [
                          SizedBox(height:ScreenSize.height(context) * 0.01),
                          Icon(Icons.call, size: 40, color:Colors.blueGrey.shade200 ),
                          SizedBox(height:ScreenSize.height(context) * 0.01),
                          Text('Call'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              title_2: "iTachyon is always ready to connect", bottomColor: Colors.blueGrey.shade100,
            ),
            CarouselSlider(
              items: [
                Image.asset('assets/bannerFour.png'),
                Image.asset('assets/bannerFive.png'),
                Image.asset('assets/bannerSix.png'),
              ],
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 2.1,
                viewportFraction: 0.97,
                onPageChanged: (index, reason) {
                },
              ),
            ),
          ]
        )
      )
    );
  }
}
