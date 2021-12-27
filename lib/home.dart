import 'package:bmi/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'authentication.dart';
import 'models/retrive_data.dart';

class Home extends StatefulWidget {
  late String email;
  late String password;

  Home(this.email, this.password);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _heightController =
      TextEditingController();
  final TextEditingController _weightController =
      TextEditingController();

  double _result = 0.0;
  DateFormat dateFormat =
      DateFormat("yyyy-MM-dd HH:mm:ss");

  late String timeString;
  late String value;

  void calculateBMI() {
    double height =
        double.parse(_heightController.text) /
            100;
    double weight =
        double.parse(_weightController.text);

    double heightSquare = height * height;
    double result = weight / heightSquare;
    _result = result;
    timeString =
        dateFormat.format(DateTime.now());
    setState(() {});

    AuthenticationHelper()
        .storeBmi(_result, timeString);
    // AuthenticationHelper().getBmi();
  }

  void showBMI() async {
    // double height =
    //     double.parse(_heightController.text) /
    //         100;
    // double weight =
    // double.parse(_weightController.text);
    //
    // double heightSquare = height * height;
    // double result = weight / heightSquare;
    // _result = result;
    // timeString =
    //     dateFormat.format(DateTime.now());
    // setState(() {});
    //
    // AuthenticationHelper()
    //     .storeBmi(_result, timeString);
    final String prefs =
        await AuthenticationHelper()
            .getBmi(context)
            .toString();
    // String values;
    setState(() {
      value = prefs;
    });
    // values = AuthenticationHelper()
    //     .getBmi()
    //     .toString();
    print(value);
  }

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
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'height in cm',
                icon: Icon(Icons.trending_up),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'weight in kg',
                icon: Icon(Icons.line_weight),
              ),
            ),
            SizedBox(height: 15),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "Calculate",
                style: TextStyle(
                    color: Colors.white),
              ),
              onPressed: calculateBMI,
            ),
            SizedBox(height: 15),
            Text(
              _result == null
                  ? "Enter Value"
                  : "${_result.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 19.4,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 15),
            RaisedButton(
              color: Colors.blue,
              child: Text(
                "Show Previous Data",
                style: TextStyle(
                    color: Colors.white),
              ),
              onPressed: showBMI,
            ),
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
