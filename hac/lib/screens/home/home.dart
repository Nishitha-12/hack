import 'package:flutter/material.dart';
import 'package:hac/models/user.dart';
import 'package:hac/screens/wrapper.dart';
import 'package:hac/services/auth.dart';
import 'package:hac/screens/profilepage/profile.dart';
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

          return Card(
              child: Container(
            height: 100,
            child: ListTile(
              // Access the fields as defined in FireStore
              title: Text('Type of work: ${work.data['Type of work']}'),
              subtitle: Text('Amount: ₹${work.data['Amount']}'),
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
      });
    });
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print('from Home page');
    // print('$name, $address, $mainarea, $phoneno');
    return Container(
        child: Scaffold(
            backgroundColor: Colors.green[50],
            drawer: SideDrawer(
              name: _name,
              address: _address,
              mainarea: _mainarea,
              phoneno: _phoneno,
            ),
            appBar: AppBar(
              title: Text("Home"),
              backgroundColor: Colors.teal,
              elevation: 0.0,
              actions: <Widget>[
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
              ],
            ),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: 550,
                  child: FutureBuilder(
                      builder: buildWorkList,
                      future:
                          Firestore.instance.collection('Work').getDocuments()),
                ),
              ],
            )));
  }
}
