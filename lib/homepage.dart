import 'package:Broadband/about.dart';
import 'package:flutter/material.dart';
import 'package:internet_speed_test/callbacks_enum.dart';
import 'package:internet_speed_test/internet_speed_test.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'data.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    internetSpeedTest = InternetSpeedTest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.data_usage,
                    color: Color(0xff555555),
                  ),
                  Text(
                    'BroadBand Usage',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Roboto',
                        color: Colors.black),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        onMenuPressed(context);
                      })
                ],
              ),
              SleekCircularSlider(
                initialValue: planMap['Type'] == 'UL'
                    ? double.parse(
                        validityPeriod.substring(0, validityPeriod.length - 4))
                    : (currentUsage + sessionUsage),
                max: planMap['Type'] == 'UL'
                    ? double.parse(planMap['Validity'].toString())
                    : double.parse(planMap['Limit'].toString()),
                appearance: CircularSliderAppearance(
                  size: MediaQuery.of(context).size.width / 1.5,
                  startAngle: -90,
                  angleRange: 360,
                  customColors: CustomSliderColors(
                    hideShadow: true,
                    trackColor: Color(0xffefefef),
                    progressBarColor: Color(0xff63bdb7),
                  ),
                  customWidths:
                      CustomSliderWidths(trackWidth: 10, progressBarWidth: 12),
                ),
                innerWidget: (percentage) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            planMap['Type'] == 'UL'
                                ? Text(
                                    (percentage.round()).toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    percentage.toStringAsFixed(2),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                            planMap['Type'] == 'UL'
                                ? Text(
                                    ' Days',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black38),
                                  )
                                : Text(
                                    ' GB',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black38),
                                  )
                          ],
                        ),
                        planMap['Type'] == 'UL'
                            ? Text(
                                'Remaining',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black38),
                              )
                            : Text(
                                'Used',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black38),
                              )
                      ],
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: Color(0xffefefef),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: planMap['Type'] == 'UL'
                            ? Column(
                                children: [
                                  Text(
                                    (sessionUsage + currentUsage)
                                            .toStringAsFixed(2) +
                                        ' GB',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Used',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black38),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    (planMap['Limit'] -
                                                sessionUsage -
                                                currentUsage)
                                            .toStringAsFixed(2) +
                                        ' GB',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Remaining',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black38),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                  Icon(Icons.link, color: Colors.black38),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: Color(0xffefefef),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: planMap['Type'] == 'UL'
                            ? Column(
                                children: [
                                  Text(
                                    'Unlimited Data',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Remaining',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black38),
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    validityPeriod.substring(
                                            0, validityPeriod.length - 4) +
                                        ' Days',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    'Remaining',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black38),
                                  )
                                ],
                              ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xffefefef),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.network_check),
                  title: Row(
                    children: [
                      Text(
                        'Down: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black38),
                      ),
                      Text(
                        '$downSpeed mb/s',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black38),
                      ),
                      Text(
                        ' - Up: ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black38),
                      ),
                      Text(
                        '$upSpeed mb/s',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black38),
                      )
                    ],
                  ),
                  onTap: () {
                    internetSpeedTest.startDownloadTesting(
                      onDone: (double transferRate, SpeedUnit unit) {
                        setState(() {
                          downSpeed = transferRate.toStringAsFixed(2);
                        });
                        internetSpeedTest.startUploadTesting(
                          onDone: (double transferRate, SpeedUnit unit) {
                            setState(() {
                              upSpeed = transferRate.toStringAsFixed(2);
                            });
                          },
                          onProgress: (double percent, double transferRate,
                              SpeedUnit unit) {
                            setState(() {
                              upSpeed = transferRate.toStringAsFixed(2);
                            });
                          },
                          onError:
                              (String errorMessage, String speedTestError) {
                            upSpeed = 'Error';
                          },
                        );
                      },
                      onProgress: (double percent, double transferRate,
                          SpeedUnit unit) {
                        setState(() {
                          downSpeed = transferRate.toStringAsFixed(2);
                        });
                      },
                      onError: (String errorMessage, String speedTestError) {
                        downSpeed = 'Error';
                      },
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xffefefef),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text(
                    name[0].toUpperCase() + name.substring(1).toLowerCase(),
                  ),
                  subtitle: Text(email),
                  onTap: () {},
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onMenuPressed(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        builder: (context) {
          return Wrap(
            children: <Widget>[
              Divider(
                thickness: 2,
                indent: MediaQuery.of(context).size.width / 3,
                endIndent: MediaQuery.of(context).size.width / 3,
              ),
              ListTile(
                leading: Icon(
                  Icons.access_time,
                ),
                title: Text('Plan'),
                subtitle: Text(plan),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.confirmation_number,
                ),
                title: Text('KV Account Number'),
                subtitle: Text(accountNum),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.router),
                title: Text('MAC Address'),
                subtitle: Text(macAddress),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.power_settings_new),
                title: Text('Log Out'),
                onTap: () {
                  upSpeed = 'Test';
                  downSpeed = 'Test';
                  username = '';
                  password = '';
                  prefs.setString('username', 'null');
                  prefs.setString('password', 'null');
                  Navigator.pop(context);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
              ),
            ],
          );
        });
  }
}
