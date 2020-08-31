import 'package:Broadband/data.dart';
import 'package:Broadband/homepage.dart';
import 'package:Broadband/loading.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
      home: LoadingPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController usernameController;
  TextEditingController passwordController;

  @override
  void initState() {
    prefs.setString('username', 'null');
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
                  setState(() {
                    buttonColor = Color(0xff0A223f);
                  });
                  username = usernameController.text;
                  password = passwordController.text;
                  clicked = true;

                  url =
                      'https://selfcare.keralavisionisp.com/Customer/Default.aspx';
                  url2 =
                      'https://selfcare.keralavisionisp.com/Customer/PortalLogin.aspx?h8=1';
                  url4 =
                      'https://selfcare.keralavisionisp.com/Customer/Gauge.aspx';
                  test(context);
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
  //plan = 'UL1Y10M';
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

  if (data.contains('FUP') || data.contains('LCOCPFUP')) {
    if (data.contains('Y')) {
      data.contains(('Y')) ? data.remove('Y') : alpha = alpha;

      return {
        'Type': 'FUP1Y',
        'Speed': int.parse(data[2]),
        'Limit': double.parse(data[3]),
        'Validity': 360
      };
    }
    if (data.length == 3) {
      data.add('30');
    }
    return {
      'Type': 'FUP',
      'Speed': int.parse(data[1]),
      'Limit': double.parse(data[2]),
      'Validity': int.parse(data[3])
    };
  } else if (data.contains('UL')) {
    if (data.contains('Y')) {
      data.contains(('Y')) ? data.remove('Y') : alpha = alpha;
      return {
        'Type': 'UL',
        'Speed': int.parse(data[2]),
        'Limit': null,
        'Validity': 365
      };
    }
    return {
      'Type': 'UL',
      'Speed': int.parse(data[1]),
      'Limit': null,
      'Validity': 30
    };
  }

  return {
    'Type': 'UL',
    'Speed': int.parse(data[1]),
    'Limit': 'NIL',
    'Validity': 'NIL'
  };
}

void test(BuildContext context) {
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
    body['txtUserName'] = username;
    body['txtPassword'] = password;
    Requests.post(url2, body: body).then((response) {
      if (response.statusCode == 302) {
//////////////////////////////////// Guage details GET Response //////////
        Requests.get(url4).then((response) {
          int index = response.content().indexOf('lblName');
          print(response.content());
          if (index != -1) {
            /////////////// Save LogIn Id ////////////////////////////////
            prefs.setString('username', username);
            prefs.setString('password', password);
/////////////////////////////////// Name ////////////////////////////////
            if (index != -1) name = parse(response, index);

/////////////////////////////////// SessionUsage ////////////////////////
            index = response.content().indexOf('lblTotalData');
            if (index != -1) {
              sessionUsage =
                  parse(response, index)[parse(response, index).length - 2] ==
                          'M'
                      ? double.parse(parse(response, index).substring(
                              6, parse(response, index).length - 3)) /
                          1024
                      : double.parse(parse(response, index)
                          .substring(6, parse(response, index).length - 3));
            } else
              sessionUsage = 0.0;

/////////////////////////////////// PlanName ///////////////////////////
            index = response.content().indexOf('lblPlanName');
            if (index != -1) {
              plan = parse(response, index);
              planMap = planDetails(plan);
            }

/////////////////////////////////// MobileNumber ///////////////////////////
            index = response.content().indexOf('lblMobile');
            if (index != -1)
              mobNumber = parse(response, index);
            else
              mobNumber = 'Not Listed';

/////////////////////////////////// AccountNumber ///////////////////////////
            index = response.content().indexOf('lblAccountNo');
            if (index != -1) accountNum = parse(response, index);

/////////////////////////////////// Address ///////////////////////////////
            index = response.content().indexOf('lblAddress');
            if (index != -1) address = parse(response, index);

/////////////////////////////////// MacAddress ///////////////////////////////
            index = response.content().indexOf('lblMacAddress');
            if (index != -1)
              macAddress = parse(response, index);
            else
              macAddress = 'Not Registered';

/////////////////////////////////// CurrentUsage ///////////////////////////
            index = response.content().indexOf('lblCurrentUsage');
            if (index != -1)
              currentUsage =
                  parse(response, index)[parse(response, index).length - 2] ==
                          'M'
                      ? double.parse(parse(response, index).substring(
                              0, parse(response, index).length - 3)) /
                          1024
                      : double.parse(parse(response, index)
                          .substring(0, parse(response, index).length - 3));

/////////////////////////////////// EmailId ////////////////////////////////
            index = response.content().indexOf('lblEmail');
            if (index != -1)
              email = parse(response, index);
            else
              email = mobNumber;

/////////////////////////////////// ValidityPeriod //////////////////////////
            index = response.content().indexOf('lblValidityPeriod');
            if (index != -1) validityPeriod = parse(response, index);

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          } else
            test(context);
        });
      } else {
        Fluttertoast.showToast(
            msg: 'Login Failed',
            timeInSecForIosWeb: 2,
            backgroundColor: Color(0x31000000));
      }
    });
  });
}
