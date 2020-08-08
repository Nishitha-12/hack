import 'package:flutter/material.dart';
import 'package:hac/screens/profilepage/profile.dart';
import 'package:hac/screens/wrapper.dart';
import 'package:hac/services/auth.dart';

class SideDrawer extends StatefulWidget {
  final String name;
  final String address;
  final String mainarea;
  final String phoneno;

  @override
  _SideDrawerState createState() => _SideDrawerState();
  SideDrawer(
      {@required this.name,
      @required this.address,
      @required this.mainarea,
      @required this.phoneno});
}

class _SideDrawerState extends State<SideDrawer> {
  final AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(223, 248, 230, 1),
// ==========Whole Drawer====================
        child: ListView(
          children: <Widget>[
// ============== Header =======================
            new UserAccountsDrawerHeader(
              accountName: Text(
                widget.name,
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                widget.phoneno,
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 55.0,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(87, 200, 159, 1),
              ),
            ),

// ================= Drawer Options ======================

            ListTile(
              title: Text("Profile"),
              trailing: Icon(Icons.person),
              onTap: () {
                print('Inside item1');
                print(widget.name);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Profile(
                          name: widget.name,
                          address: widget.address,
                          phoneno: widget.phoneno,
                          mainarea: widget.mainarea,
                        )));
              },
            ),

            Divider(
              color: Colors.black,
              thickness: 1,
              height: 16,
            ),

            Align(
              alignment: Alignment.topLeft,
              heightFactor: 28.0,
              widthFactor: 72.0,
              child: Container(
                margin: const EdgeInsets.only(left: 32.0, top: 16.0),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(
                          width: 2.0, color: Color.fromRGBO(102, 102, 102, 1)),
                    ),
                    color: Color.fromRGBO(182, 229, 195, 1),
                    onPressed: () async {
                      _authService.phoneSignOut(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Wrapper()));
                    },
                    child: Text(
                      'SIGN OUT',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
