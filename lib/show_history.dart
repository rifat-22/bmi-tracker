import 'package:bmi/login.dart';

import 'package:flutter/material.dart';

import 'authentication.dart';

class ShowHistory extends StatefulWidget {
  late String data;

  ShowHistory(this.data);
  @override
  State<ShowHistory> createState() =>
      _ShowHistoryState();
}

class _ShowHistoryState
    extends State<ShowHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Tracker'),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 10.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text(widget.data)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AuthenticationHelper().signOut().then(
              (_) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (contex) =>
                            Login()),
                  ));
        },
        child: Icon(Icons.logout),
        tooltip: 'Logout',
      ),
    );
  }
}
