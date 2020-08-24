import 'dart:async';

import 'package:Broadband/data.dart';
import 'package:Broadband/homepage.dart';
import 'package:flutter/material.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
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
    internetSpeedTest = InternetSpeedTest();
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
                  // internetSpeedTest.startUploadTesting(
                  //   onDone: (double transferRate, SpeedUnit unit) {
                  //     print('the transfer rate $transferRate');
                  //     setState(() {
                  //       upSpeed = transferRate.toString();
                  //     });
                  //   },
                  //   onProgress:
                  //       (double percent, double transferRate, SpeedUnit unit) {
                  //     print(
                  //         'the transfer rate $transferRate, the percent $percent');
                  //     setState(() {
                  //       upSpeed = transferRate.toString();
                  //     });
                  //   },
                  //   onError: (String errorMessage, String speedTestError) {
                  //       upSpeed = 'Error';
                  //   },
                  // );
                  // internetSpeedTest.startDownloadTesting(
                  //   onDone: (double transferRate, SpeedUnit unit) {
                  //     setState(() {
                  //       downSpeed = transferRate.toString();
                  //     });
                  //   },
                  //   onProgress:
                  //       (double percent, double transferRate, SpeedUnit unit) {
                  //       downSpeed = transferRate.toString();
                  //   },
                  //   onError: (String errorMessage, String speedTestError) {
                  //       downSpeed = 'Error';
                  //   },
                  // );
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
      print('---------1');
      print(response.content());
      int viewstateind = response.content().indexOf('__VIEWSTATE');
      int viewstategeneratorind =
          response.content().indexOf('__VIEWSTATEGENERATOR');
      int eventvalidationind = response.content().indexOf('__EVENTVALIDATION');

//////////////////////////////////////// ViewState /////////////////////
      slicedResponse =
          response.content().substring(viewstateind, viewstateind + 4500);
      for (i = 0; i < slicedResponse.length; i++)
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
      for (var i = 0; i < slicedResponse.length; i++)
        if (slicedResponse[i] == '/' && startIndex == null)
          startIndex = i;
        else if (slicedResponse[i] == '"' &&
            endIndex == null &&
            startIndex != null) endIndex = i;
      eventvalidation = slicedResponse.substring(startIndex, endIndex);

      /// LogIn POST Response /////////////////////
      Requests.post(url2, body: body).then((response) {
        print('---------2');
        print(response.content());
        if (response.statusCode == 302) {
          Requests.get(url5).then((response) {
 print('---------3');
             print(response.content());
            Requests.get(url4).then((response) {
              print('---------4');
              print(response.content());
              int numind = response.content().indexOf('lblMobile');
              int nameind = response.content().indexOf('lblName');
              int emailind = response.content().indexOf('lblEmail');
              int valind = response.content().indexOf('lblValidityPeriod');
              int currind = response.content().indexOf('lblCurrentUsage');
              int adddresind = response.content().indexOf('lblAddress');
              int planind = response.content().indexOf('lblPlanName');
              int sessind = response.content().indexOf('lblTotalData');
              if (numind != -1) {
                if (sessind != -1) {
                  slicedResponse =
                      response.content().substring(sessind, sessind + 50);
                  for (i = 0; i < slicedResponse.length; i++)
                    if (slicedResponse[i] == '>' && startIndex == null)
                      startIndex = i;
                    else if (slicedResponse[i] == '<' && endIndex == null)
                      endIndex = i;
                  sessionUsage =
                      slicedResponse.substring(startIndex + 1, endIndex);
                }
                if (planind != -1) {
                  slicedResponse =
                      response.content().substring(planind, planind + 250);
                  for (i = 0; i < slicedResponse.length; i++)
                    if (slicedResponse[i] == '>' && startIndex == null)
                      startIndex = i;
                    else if (slicedResponse[i] == '<' && endIndex == null)
                      endIndex = i;

                  plan = slicedResponse.substring(startIndex + 1, endIndex);
                  planMap = planDetails(plan);
                }

                if (numind != -1) {
                  slicedResponse =
                      response.content().substring(numind, numind + 60);
                  for (i = 0; i < slicedResponse.length; i++)
                    if (slicedResponse[i] == '>' && startIndex == null)
                      startIndex = i;
                    else if (slicedResponse[i] == '<' && endIndex == null)
                      endIndex = i;

                  mobNumber =
                      slicedResponse.substring(startIndex + 1, endIndex);
                }
                {
                  slicedResponse =
                      response.content().substring(nameind, nameind + 150);
                  for (i = 0; i < slicedResponse.length; i++)
                    if (slicedResponse[i] == '>' && startIndex == null)
                      startIndex = i;
                    else if (slicedResponse[i] == '<' && endIndex == null)
                      endIndex = i;

                  name = slicedResponse.substring(startIndex + 1, endIndex);
                }
                if (emailind != -1) {
                  slicedResponse =
                      response.content().substring(emailind, emailind + 70);
                  for (i = 0; i < slicedResponse.length; i++)
                    if (slicedResponse[i] == '>' && startIndex == null)
                      startIndex = i;
                    else if (slicedResponse[i] == '<' && endIndex == null)
                      endIndex = i;

                  email = slicedResponse.substring(startIndex + 1, endIndex);
                } else
                  email = mobNumber;
                {
                  slicedResponse = response
                      .content()
                      .substring(adddresind, adddresind + 200);
                  for (i = 0; i < slicedResponse.length; i++)
                    if (slicedResponse[i] == '>' && startIndex == null)
                      startIndex = i;
                    else if (slicedResponse[i] == '<' && endIndex == null)
                      endIndex = i;

                  address = slicedResponse.substring(startIndex + 1, endIndex);
                }
                if (valind != -1) {
                  slicedResponse =
                      response.content().substring(valind, valind + 50);
                  for (i = 0; i < slicedResponse.length; i++)
                    if (slicedResponse[i] == '>' && startIndex == null)
                      startIndex = i;
                    else if (slicedResponse[i] == '<' && endIndex == null)
                      endIndex = i;
                  validityPeriod =
                      slicedResponse.substring(startIndex + 1, endIndex);
                } else
                  validityPeriod = '0 Days';
                if (currind != -1) {
                  slicedResponse =
                      response.content().substring(currind, currind + 50);
                  for (i = 0; i < slicedResponse.length; i++) {
                    if (slicedResponse[i] == '>' && startIndex == null)
                      startIndex = i;
                    if (slicedResponse[i] == '<' && endIndex == null)
                      endIndex = i;
                  }
                  currentUsage =
                      slicedResponse.substring(startIndex + 1, endIndex);
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
