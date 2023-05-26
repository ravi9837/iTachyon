import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itachyon/const/appColor.dart';
import 'package:itachyon/const/screenSize.dart';
import 'package:itachyon/views/HomePage/homePage.dart';

class ManageTicketPage extends StatefulWidget {
  const ManageTicketPage({Key? key}) : super(key: key);

  @override
  State<ManageTicketPage> createState() => _ManageTicketPageState();
}


class _ManageTicketPageState extends State<ManageTicketPage> {

  late Map<String, dynamic> ticketData;

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
      Map<String, dynamic> ticketData = userDocument.data()!;
      // String name = userData['firstname'];
      // String email = userData['email'];
      // Access other fields similarly

      // Use the user data as needed
      // print('Name: $name');
      // print('Age: $email');
      // Print/access other fields similarly
    }
    return ticketData;
  }


  Future<DocumentSnapshot<Map<String, dynamic>>?> getUserDocument() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      String email = currentUser.email!;
      DocumentReference<Map<String, dynamic>> userDocRef =
      FirebaseFirestore.instance.collection('users').doc(email).collection('tickets').doc('23IaSDuHsEWxFnvJP5D9');

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
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
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: AppColor.blue,
              )),
          bottom: TabBar(
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(40), // Creates border
                color: AppColor.fadeblue),
            tabs: [
              Tab(
                icon: Icon(
                  Icons.new_label,
                  color: AppColor.blue,
                ),
                child: Text(
                  "New Ticket",
                  style: TextStyle(
                    color: AppColor.blue,
                  ),
                ),
                height: ScreenSize.height(context) * 0.05,
                iconMargin: const EdgeInsets.only(),
              ),
              Tab(
                icon: Icon(
                  Icons.construction,
                  color: AppColor.blue,
                ),
                child: Text(
                  "In Progress",
                  style: TextStyle(
                    color: AppColor.blue,
                  ),
                ),
                height: ScreenSize.height(context) * 0.05,
                iconMargin: const EdgeInsets.only(),
              ),
              Tab(
                icon: Icon(
                  Icons.close,
                  color: AppColor.blue,
                ),
                child: Text(
                  "Closed Ticket",
                  style: TextStyle(
                    color: AppColor.blue,
                  ),
                ),
                height: ScreenSize.height(context) * 0.05,
                iconMargin: const EdgeInsets.only(),
              ),
            ],
          ),
        ),
      ),
          body: TabBarView(
            children: [
              ListView.builder(
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
                          title: Text('${ticketData["title"]}'),
                          subtitle: Text('${ticketData["description"]}')
                      ),
                          // title: Text(userData['title'])),
                    );
                  }),
              ListView.builder(
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
                          title: Text("List  $index")),
                    );
                  }),
              ListView.builder(
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
                          title: Text("$index")),
                    );
                  }),
            ],
          )
      ),
    );
  }
}
