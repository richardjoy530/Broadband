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
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomLeft,
        //       colors: [Color(0xff0d4dff),Color(0xffffffff)])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text('KeralaVision\n BroadBand',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      fontFamily: 'Roboto',
                      color: Colors.black)),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: usernameController,
                        maxLines: 1,
                        maxLength: 20,
                        decoration: InputDecoration(
                            hintText: 'Username',
                            border: InputBorder.none,
                            counterText: ''),
                      ),
                    ),
                  ),
                  Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: passwordController,
                        maxLines: 1,
                        maxLength: 20,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                            counterText: ''),
                      ),
                    ),
                  ),
                ],
              ),
              Listener(
                onPointerUp: (pointerUpEvent) {
                  username = usernameController.text;
                  password = passwordController.text;
                  test();
                  print([usernameController.text, passwordController.text]);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Color(0xff00d0a5),
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
    var url = 'https://myaccount.keralavisionisp.com/Customer/Default.aspx';
    Requests.get(url).then((response) {
      var viewstateind = response.content().indexOf('__VIEWSTATE');
      var viewstategeneratorind =
          response.content().indexOf('__VIEWSTATEGENERATOR');
      var eventvalidationind = response.content().indexOf('__EVENTVALIDATION');
      {
        var viewstatedata =
            response.content().substring(viewstateind, viewstateind + 4500);
        int startIndex;
        int endIndex;
        for (var i = 0; i < viewstatedata.length; i++) {
          if (viewstatedata[i] == '/' && startIndex == null) startIndex = i;
          if (viewstatedata[i] == '"' && endIndex == null && startIndex != null)
            endIndex = i;
        }
        setState(() {
          viewstate = viewstatedata.substring(startIndex, endIndex);
        });
      }
      {
        var viewstategeneratordata = response
            .content()
            .substring(viewstategeneratorind, viewstategeneratorind + 100);
        int startIndex = 55;
        int endIndex = 63;
        setState(() {
          viewstategenerator =
              viewstategeneratordata.substring(startIndex, endIndex);
        });
      }
      {
        var eventvalidationdata = response
            .content()
            .substring(eventvalidationind, eventvalidationind + 300);
        int startIndex;
        int endIndex;
        for (var i = 0; i < eventvalidationdata.length; i++) {
          if (eventvalidationdata[i] == '/' && startIndex == null)
            startIndex = i;
          if (eventvalidationdata[i] == '"' &&
              endIndex == null &&
              startIndex != null) endIndex = i;
        }
        setState(() {
          eventvalidation = eventvalidationdata.substring(startIndex, endIndex);
        });
      }

      url =
          'https://myaccount.keralavisionisp.com/Customer/PortalLogin.aspx?h8=1';

      Requests.post(url,
              body: body, bodyEncoding: RequestBodyEncoding.FormURLEncoded)
          .then((response) {
        if (response.statusCode == 302) {
          url =
              'https://myaccount.keralavisionisp.com/Customer/HomePage.aspx?Id=147205';
          Requests.get(url).then((response) {
            url = 'https://myaccount.keralavisionisp.com/Customer/Gauge.aspx';
            Requests.get(url).then((response) {
              var numind = response.content().indexOf('lblMobile');
              var nameind = response.content().indexOf('lblName');
              var emailind = response.content().indexOf('lblEmail');
              var valind = response.content().indexOf('lblValidityPeriod');
              var currind = response.content().indexOf('lblCurrentUsage');
              var adddresind = response.content().indexOf('lblAddress');
              var planind = response.content().indexOf('lblPlanName');
              var sessind = response.content().indexOf('lblTotalData');
              if (numind != -1) {
                {
                  var sessdata =
                      response.content().substring(sessind, sessind + 50);
                  int startIndex;
                  int endIndex;
                  for (var i = 0; i < sessdata.length; i++) {
                    if (sessdata[i] == '>' && startIndex == null)
                      startIndex = i;
                    if (sessdata[i] == '<' && endIndex == null) endIndex = i;
                  }
                  setState(() {
                    sessionUsage = sessdata.substring(startIndex + 1, endIndex);
                  });
                }
                {
                  var plandata =
                      response.content().substring(planind, planind + 250);
                  int startIndex;
                  int endIndex;
                  for (var i = 0; i < plandata.length; i++) {
                    if (plandata[i] == '>' && startIndex == null)
                      startIndex = i;
                    if (plandata[i] == '<' && endIndex == null) endIndex = i;
                  }
                  setState(() {
                    plan = plandata.substring(startIndex + 1, endIndex);
                  });
                }
                planMap = planDetails(plan);
                {
                  var numdata =
                      response.content().substring(numind, numind + 60);
                  int startIndex;
                  int endIndex;
                  for (var i = 0; i < numdata.length; i++) {
                    if (numdata[i] == '>' && startIndex == null) startIndex = i;
                    if (numdata[i] == '<' && endIndex == null) endIndex = i;
                  }
                  setState(() {
                    mobNumber = numdata.substring(startIndex + 1, endIndex);
                  });
                }
                {
                  var namedata =
                      response.content().substring(nameind, nameind + 150);
                  int startIndex;
                  int endIndex;
                  for (var i = 0; i < namedata.length; i++) {
                    if (namedata[i] == '>' && startIndex == null)
                      startIndex = i;
                    if (namedata[i] == '<' && endIndex == null) endIndex = i;
                  }
                  setState(() {
                    name = namedata.substring(startIndex + 1, endIndex);
                  });
                }
                {
                  var emaildata =
                      response.content().substring(emailind, emailind + 70);
                  int startIndex;
                  int endIndex;
                  for (var i = 0; i < emaildata.length; i++) {
                    if (emaildata[i] == '>' && startIndex == null)
                      startIndex = i;
                    if (emaildata[i] == '<' && endIndex == null) endIndex = i;
                  }
                  setState(() {
                    email = emaildata.substring(startIndex + 1, endIndex);
                  });
                }
                {
                  var addressdata = response
                      .content()
                      .substring(adddresind, adddresind + 200);
                  int startIndex;
                  int endIndex;
                  for (var i = 0; i < addressdata.length; i++) {
                    if (addressdata[i] == '>' && startIndex == null)
                      startIndex = i;
                    if (addressdata[i] == '<' && endIndex == null) endIndex = i;
                  }
                  setState(() {
                    address = addressdata.substring(startIndex + 1, endIndex);
                  });
                }
                {
                  var valdata =
                      response.content().substring(valind, valind + 50);
                  int startIndex;
                  int endIndex;
                  for (var i = 0; i < valdata.length; i++) {
                    if (valdata[i] == '>' && startIndex == null) startIndex = i;
                    if (valdata[i] == '<' && endIndex == null) endIndex = i;
                  }
                  setState(() {
                    validityPeriod =
                        valdata.substring(startIndex + 1, endIndex);
                  });
                }
                {
                  var currdata =
                      response.content().substring(currind, currind + 50);
                  int startIndex;
                  int endIndex;
                  for (var i = 0; i < currdata.length; i++) {
                    if (currdata[i] == '>' && startIndex == null)
                      startIndex = i;
                    if (currdata[i] == '<' && endIndex == null) endIndex = i;
                  }
                  setState(() {
                    currentUsage = currdata.substring(startIndex + 1, endIndex);
                  });
                }
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              } else
                test();
            });
          });
        }
      });
    });
  }
}
