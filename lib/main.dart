import 'dart:async';

import 'package:Broadband/data.dart';
import 'package:Broadband/homepage.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/login.png'), fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('KeralaVision\n BroadBand',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      color: Color(0xff1F4D84))),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffE1ECF9)),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: TextField(
                        style: TextStyle(color: Color(0xff0A223f)),
                        cursorColor: Color(0xff0A223f),
                        textAlign: TextAlign.center,
                        controller: usernameController,
                        maxLines: 1,
                        maxLength: 20,
                        decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: TextStyle(color: Color(0xffA0B3C9)),
                            border: InputBorder.none,
                            counterText: ''),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffE1ECF9)),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        style: TextStyle(color: Color(0xff0A223f)),
                        textAlign: TextAlign.center,
                        cursorColor: Color(0xff0A223f),
                        controller: passwordController,
                        maxLines: 1,
                        maxLength: 20,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Color(0xffA0B3C9)),
                            border: InputBorder.none,
                            counterText: ''),
                      ),
                    ),
                  ),
                ],
              ),
              Listener(
                onPointerDown: (pointerDownEvent) {
                  setState(() {
                    buttonColor = Color(0xff1F4D84);
                  });
                },
                onPointerUp: (pointerUpEvent) {
                  buttonColor = Color(0xff0A223f);
                  username = usernameController.text;
                  password = passwordController.text;
                  test();
                  // username = 'drradhakrishnan1647';
                  // password = 'drradhakrishnan1647';
                  print([usernameController.text, passwordController.text]);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 75,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: Center(
                      child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Roboto'),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> test() async {
    /// LogIn Page GET Response /////////////////////
    Requests.get(url).then((response) {
      int viewstateind = response.content().indexOf('__VIEWSTATE');
      int viewstategeneratorind =
          response.content().indexOf('__VIEWSTATEGENERATOR');
      int eventvalidationind = response.content().indexOf('__EVENTVALIDATION');

//////////////////////////////////////// ViewState /////////////////////
      slicedResponse =
          response.content().substring(viewstateind, viewstateind + 4500);
      startIndex = null;
      endIndex = null;
      for (i = 0; endIndex == null; i++)
        if (slicedResponse[i] == '/' && startIndex == null)
          startIndex = i;
        else if (slicedResponse[i] == '"' &&
            endIndex == null &&
            startIndex != null) endIndex = i;
      viewstate = slicedResponse.substring(startIndex, endIndex);

//////////////////////////////// ViewstateGenerator /////////////////////
      slicedResponse = response
          .content()
          .substring(viewstategeneratorind, viewstategeneratorind + 100);
      startIndex = 55;
      endIndex = 63;
      viewstategenerator = slicedResponse.substring(startIndex, endIndex);

/////////////////////////////////// EventValidation /////////////////////
      slicedResponse = response
          .content()
          .substring(eventvalidationind, eventvalidationind + 300);
      startIndex = null;
      endIndex = null;
      for (var i = 0; endIndex == null; i++)
        if (slicedResponse[i] == '/' && startIndex == null)
          startIndex = i;
        else if (slicedResponse[i] == '"' &&
            endIndex == null &&
            startIndex != null) endIndex = i;
      eventvalidation = slicedResponse.substring(startIndex, endIndex);

      //// LogIn POST Response /////////////////////
      Requests.post(url2, body: body).then((response) {
        if (response.statusCode == 302) {
//////////////////////////////////// Guage details GET Response //////////
          Requests.get(url4).then((response) {
            int index = response.content().indexOf('lblName');
            if (index != -1) {
/////////////////////////////////// Name ////////////////////////////////
              if (index != -1) name = parse(response, index);

/////////////////////////////////// SessionUsage ////////////////////////
              index = response.content().indexOf('lblTotalData');
              if (index != -1) sessionUsage = parse(response, index);

/////////////////////////////////// PlanName ///////////////////////////
              index = response.content().indexOf('lblPlanName');
              if (index != -1) {
                plan = parse(response, index);
                planMap = planDetails(plan);
              }

/////////////////////////////////// MobileNumber ///////////////////////////
              index = response.content().indexOf('lblMobile');
              if (index != -1) mobNumber = parse(response, index);

/////////////////////////////////// Address ///////////////////////////////
              index = response.content().indexOf('lblAddress');
              if (index != -1) address = parse(response, index);

/////////////////////////////////// CurrentUsage ///////////////////////////
              index = response.content().indexOf('lblCurrentUsage');
              if (index != -1) currentUsage = parse(response, index);

/////////////////////////////////// EmailId ////////////////////////////////
              index = response.content().indexOf('lblEmail');
              if (index != -1) email = parse(response, index);

/////////////////////////////////// ValidityPeriod //////////////////////////
              index = response.content().indexOf('lblValidityPeriod');
              if (index != -1) validityPeriod = parse(response, index);

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            } else
              test();
          });
        }
      });
    });
  }

  String parse(Response response, int index, {int offset = 500}) {
    startIndex = null;
    endIndex = null;
    slicedResponse = response.content().substring(index, index + offset);
    for (i = 0; endIndex == null; i++)
      if (slicedResponse[i] == '>' && startIndex == null)
        startIndex = i;
      else if (slicedResponse[i] == '<' && endIndex == null) endIndex = i;
    return slicedResponse.substring(startIndex + 1, endIndex);
  }

  Map<String, dynamic> planDetails(String plan) {
    var alpha = '';
    var numero = '';
    List<String> data = [];
    for (var i = 0; i < plan.length; i++) {
      if (plan[i].contains(RegExp(r'[A-Z]'))) {
        alpha += plan[i];
        numero != '' ? data.add(numero) : numero = numero;
        numero = '';
      }
      if (plan[i].contains(RegExp(r'[0-9]'))) {
        numero += plan[i];
        alpha != '' ? data.add(alpha) : alpha = alpha;
        alpha = '';
      }
    }
    data.contains(('M')) ? data.remove('M') : alpha = alpha;
    data.contains(('G')) ? data.remove('G') : alpha = alpha;

    if (data.length == 3) {
      data.add('30');
    }

    if (data.contains('FUP'))
      return {
        'Type': 'FUP',
        'Speed': int.parse(data[1]),
        'Limit': double.parse(data[2]),
        'Validity': int.parse(data[3])
      };
    else if (data.contains('UL'))
      return {
        'Type': 'UL30',
        'Speed': int.parse(data[1]),
        'Limit': 'NIL',
        'Validity': 30
      };

    return {
      'Type': 'UL',
      'Speed': int.parse(data[1]),
      'Limit': 'NIL',
      'Validity': 'NIL'
    };
  }
}
