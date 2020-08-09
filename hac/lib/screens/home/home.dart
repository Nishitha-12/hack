import 'package:flutter/material.dart';
import 'package:hac/screens/workdata.dart';

import 'package:hac/screens/wrapper.dart';
import 'package:hac/services/auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hac/sideDrawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();

  final firestoreInstance = Firestore.instance;

  String _name = '';
  String _address = '';
  String _mainarea = '';
  String _phoneno = '';
  String _uid = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  Widget buildWorkList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot work = snapshot.data.documents[index];
          String workID = work.documentID;

          return Card(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.lightBlue[100], Colors.yellow[100]]),
              //color: Colors.green[100],
            ),
            //color: Colors.green[100],
            height: 100,
            child: ListTile(
              isThreeLine: true,
              trailing: Icon(Icons.keyboard_arrow_right),
              // Access the fields as defined in FireStore
              title: Text(
                'Type of work: ${work.data['Type of work']}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Lora',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              subtitle: Column(
                children: <Widget>[
                  Text(
                    'Amount: ₹${work.data['Amount']}',
                    style: TextStyle(
                      fontFamily: 'Lora',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    'Location: ${work.data['Work Location']}',
                    style: TextStyle(
                      fontFamily: 'Lora',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              onTap: () {
                print(work.data);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => WorkData(
                              work: work.data,
                              c_id: _uid,
                              c_name: _name,
                              c_number: _phoneno,
                              workID: workID,
                            )));
              },
            ),
          ));
        },
      );
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      // Handle no data
      return Center(
        child: Text("No users found."),
      );
    } else {
      // Still loading
      return CircularProgressIndicator();
    }
  }

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    firestoreInstance
        .collection("Contractors")
        .document(user.uid)
        .get()
        .then((value) {
      print(value.data);

      setState(() {
        _name = value['Name'];
        _address = value['Address'];
        _mainarea = value['Main Area'];
        _phoneno = value['Phone Number'];
        _uid = user.uid;
      });
    });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print('from Home page');
    // print('$name, $address, $mainarea, $phoneno');
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      drawer: SideDrawer(
          name: _name,
          address: _address,
          mainarea: _mainarea,
          phoneno: _phoneno),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/images/pic12.jpg'),
          fit: BoxFit.contain,
        )),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton.icon(
                      onPressed: () async {
                        _authService.phoneSignOut(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Wrapper()));
                      },
                      icon: Icon(Icons.person),
                      label: Text('LOGOUT')),
                  Container(
                    width: 125.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'HOME',
                    style: TextStyle(
                        fontFamily: 'Sriracha',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0),
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: MediaQuery.of(context).size.height - 185.0,
              decoration: BoxDecoration(
                // image:
                //     const DecorationImage(image: AssetImage('images/pic2.png')),
                color: Colors.yellow[100],

                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
              child: ListView(
                primary: false,
                padding: EdgeInsets.only(left: 25.0, right: 20.0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 45.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 300.0,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            // padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            height: 550,
                            child: FutureBuilder(
                                builder: buildWorkList,
                                future: Firestore.instance
                                    .collection('Work')
                                    .getDocuments()),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
