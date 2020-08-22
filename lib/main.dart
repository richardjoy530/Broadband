import 'dart:async';

import 'package:Broadband/data.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            TextField(
              controller: usernameController,
              maxLines: 1,
              maxLength: 20,
              decoration: InputDecoration(hintText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              maxLines: 1,
              maxLength: 20,
              decoration: InputDecoration(hintText: 'Password'),
            ),
            RaisedButton(
              child: Text('Login'),
              onPressed: () {
                username = usernameController.text;
                password = passwordController.text;
                test();
                print([usernameController.text, passwordController.text]);
              },
            ),
            Text('Name : $name'),
            Text('Mobile Number : $mobNumber'),
            Text('Email Id : $email'),
            Text('Address : $address'),
            Text('Validity : $validityPeriod'),
            Text('Total Usage : $currentUsage'),
          ],
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
            if(response.statusCode==302){

            
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
            if (numind != -1) { 
              {
                var numdata = response.content().substring(numind, numind + 60);
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
                  if (namedata[i] == '>' && startIndex == null) startIndex = i;
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
                  if (emaildata[i] == '>' && startIndex == null) startIndex = i;
                  if (emaildata[i] == '<' && endIndex == null) endIndex = i;
                }
                setState(() {
                  email = emaildata.substring(startIndex + 1, endIndex);
                });
              }
              {
                var addressdata =
                    response.content().substring(adddresind, adddresind + 200);
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
                var valdata = response.content().substring(valind, valind + 50);
                int startIndex;
                int endIndex;
                for (var i = 0; i < valdata.length; i++) {
                  if (valdata[i] == '>' && startIndex == null) startIndex = i;
                  if (valdata[i] == '<' && endIndex == null) endIndex = i;
                }
                setState(() {
                  validityPeriod = valdata.substring(startIndex + 1, endIndex);
                });
              }
              {
                var currdata =
                    response.content().substring(currind, currind + 50);
                int startIndex;
                int endIndex;
                for (var i = 0; i < currdata.length; i++) {
                  if (currdata[i] == '>' && startIndex == null) startIndex = i;
                  if (currdata[i] == '<' && endIndex == null) endIndex = i;
                }
                setState(() {
                  currentUsage = currdata.substring(startIndex + 1, endIndex);
                });
              }
            } else
              test();
          });
        });}
      });
    });
  }
}
