import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkData extends StatefulWidget {
  Map work;

  String workID;
  String c_name;
  String c_number;

  String c_id;

  @override
  _WorkDataState createState() => _WorkDataState();
  WorkData({
    @required this.work,
    @required this.workID,
    @required this.c_name,
    @required this.c_id,
    @required this.c_number,
  });
}

class _WorkDataState extends State<WorkData> {
  final _amountController = TextEditingController();
  final firestoreInstance = Firestore.instance;
  AlertDialog done = AlertDialog(title: Text("Done!"));

  @override
  Widget build(BuildContext context) {
    print(widget.work);
    return Scaffold(
        backgroundColor: Colors.red[500],
        body: Container(
          constraints: BoxConstraints.expand(),

          margin: EdgeInsets.all(30),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(25.0),
          //   gradient: LinearGradient(
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft,
          //       colors: [Colors.blueGrey[900], Colors.brown[100]]),

          child: Container(
              decoration: new BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 15.0, // soften the shadow
                    spreadRadius: 5.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      10.0, // Move to bottom 10 Vertically
                    ),
                  ),
                ],
                borderRadius: BorderRadius.circular(25.0),
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Colors.deepOrangeAccent[100],
                      Colors.deepOrange[50]
                    ]),
              ),
              height: 600,
              width: 400,
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 2),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: widget.work['Hirer name'],
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 2),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: widget.work['Type of work'],
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 2),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: widget.work['Work Location'],
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 2),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: widget.work['Number of days'],
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 2),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: widget.work['Number of workers'],
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 2),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: widget.work['Amount'],
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 2),
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: widget.work['Comments'],
                        hintStyle: TextStyle(fontWeight: FontWeight.bold),
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                      ),
                    ),
                    SizedBox(height: 2),
                    TextFormField(
                      controller: _amountController..text = '',
                      decoration: InputDecoration(
                        //focusColor: Colors.blue,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.grey[50],
                        hintText: 'Amount in Rupees',
                        contentPadding: new EdgeInsets.symmetric(
                            vertical: 13.0, horizontal: 20.0),
                      ),
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 2),
                    FlatButton(
                        child: Text(
                          "Propose this Amount",
                          style: TextStyle(
                              fontFamily: 'Lora', fontWeight: FontWeight.bold),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            side: BorderSide(color: Colors.white)),
                        color: Color(0xff57c89f),
                        textColor: Colors.white,
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          firestoreInstance
                              .collection("Work")
                              .document(widget.workID)
                              .updateData({
                            widget.c_id: [
                              widget.c_name,
                              _amountController.text,
                              widget.c_number
                            ],
                          }).then((_) {
                            print("success!");
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context).pop(true);
                                });
                                return done;
                              },
                            );
                          });

                          Navigator.pop(context);
                        }),
                    SizedBox(height: 2),
                    FlatButton(
                        child: Text("Go back",
                            style: TextStyle(
                              fontFamily: 'Lora',
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            )),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23.0),
                            side: BorderSide(color: Colors.grey)),
                        color: Colors.white,
                        textColor: Color(0xff57c89f),
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              )),
        ));
  }
}
