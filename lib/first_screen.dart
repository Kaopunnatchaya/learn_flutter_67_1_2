// lib/first_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    // เริ่มนับเวลาเปิด SecondScreen หลัง splash
    Timer(
      const Duration(seconds: 15),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SecondScreen()),
      ),
    );
    // ตรวจเช็ค Internet ตอนเปิดแอป
    checkInternetConnection();
  }

  void checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      _showToast(context, "Mobile network available.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      _showToast(context, "Wifi network available.");
    } else if (connectivityResult == ConnectivityResult.ethernet) {
      _showToast(context, "Ethernet network available.");
    } else if (connectivityResult == ConnectivityResult.vpn) {
      _showToast(context, "Vpn network available.");
    } else if (connectivityResult == ConnectivityResult.bluetooth) {
      _showToast(context, "Bluetooth network available.");
    } else if (connectivityResult == ConnectivityResult.other) {
      _showToast(context, "Other network available.");
    } else if (connectivityResult == ConnectivityResult.none) {
      _showAlertDialog(
        context,
        "No Internet Connection",
        "Please check your internet connection.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/image/icon.png'), width: 200),
              SizedBox(height: 50),
              SpinKitSpinningLines(color: Colors.deepPurple, size: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}

void _showToast(BuildContext context, String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.lightGreen,
    textColor: Colors.white,
    fontSize: 18.0,
  );
}

void _showAlertDialog(BuildContext context, String title, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(msg),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Screen')),
      body: const Center(
        child: Text(
          'This is the Second Screen',
          style: TextStyle(
            fontSize: 24,
            color: Colors.amberAccent,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}