import 'package:Broadband/data.dart';
import 'package:Broadband/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      if ((prefs.getString('username') ?? 'null') == 'null') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else {
        username = prefs.getString('username');
        password = prefs.getString('password');
        test(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center( 
        child: Container(
          width: 50,
          child: Image.asset('images/icon.png'),
        ),
      ),
    );
  }
}
