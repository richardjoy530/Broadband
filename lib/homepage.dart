import 'package:Broadband/about.dart';
import 'package:flutter/material.dart';
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
                  IconButton(
                      icon: Icon(
                        Icons.data_usage,
                        color: BroadBandTheme.iconColor,
                      ),
                      onPressed: () {}),
                  Text(
                    'BroadBand Usage',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'Roboto',
                        color: BroadBandTheme.primaryFontColor),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: BroadBandTheme.iconColor,
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
                    trackColor: BroadBandTheme.trackColor,
                    progressBarColor: BroadBandTheme.progressBarColor,
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
                                        color: BroadBandTheme.secondaryFontColor),
                                  )
                                : Text(
                                    ' GB',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w300,
                                        color: BroadBandTheme.secondaryFontColor),
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
                                    color: BroadBandTheme.secondaryFontColor),
                              )
                            : Text(
                                'Used',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: BroadBandTheme.secondaryFontColor),
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
                      color: BroadBandTheme.boxBackground,
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
                                        color: BroadBandTheme.secondaryFontColor),
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
                                        color: BroadBandTheme.secondaryFontColor),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                  Icon(Icons.link, color: BroadBandTheme.iconColor),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: BroadBandTheme.boxBackground,
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
                                        color: BroadBandTheme.secondaryFontColor),
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
                                        color: BroadBandTheme.secondaryFontColor),
                                  )
                                ],
                              ),
                      ),
                    ),
                  )
                ],
              ),
              //SpeedTest(),
              DailyUsage(),
              AboutTile()
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
                  Icons.access_time, color: BroadBandTheme.iconColor,
                ),
                title: Text('Plan'),
                subtitle: Text(plan),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(
                  Icons.confirmation_number, color: BroadBandTheme.iconColor,
                ),
                title: Text('KV Account Number'),
                subtitle: Text(accountNum),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.router, color: BroadBandTheme.iconColor,
                ),
                title: Text('MAC Address'),
                subtitle: Text(macAddress),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info, color: BroadBandTheme.iconColor,
                ),
                title: Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
              ),
              ListTile(
                leading: Icon(Icons.power_settings_new, color: BroadBandTheme.iconColor,
                ),
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

class DailyUsage extends StatelessWidget {
  const DailyUsage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return planMap['Type'] == 'UL'? Container(
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                color: BroadBandTheme.boxBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      ((sessionUsage + currentUsage) /
                                  (planMap["Validity"] -
                                      int.parse(
                                          validityPeriod.substring(
                                              0,
                                              validityPeriod.length -
                                                  4))))
                              .toStringAsFixed(2) +
                          ' GB',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Daily Average',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: BroadBandTheme.secondaryFontColor),
                    )
                  ],
                )),
              ),
            ): Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Average Daily Usage",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w300, color: BroadBandTheme.secondaryFontColor),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                color: BroadBandTheme.boxBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      ((sessionUsage + currentUsage) /
                                  (planMap["Validity"] -
                                      int.parse(
                                          validityPeriod.substring(
                                              0,
                                              validityPeriod.length -
                                                  4))))
                              .toStringAsFixed(2) +
                          ' GB',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Actual',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: BroadBandTheme.secondaryFontColor),
                    )
                  ],
                )),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                color: BroadBandTheme.boxBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      ((planMap['Limit'] -
                                      sessionUsage -
                                      currentUsage) /
                                  (int.parse(validityPeriod.substring(
                                      0, validityPeriod.length - 4))))
                              .toStringAsFixed(2) +
                          ' GB',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Expected',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: BroadBandTheme.secondaryFontColor),
                    )
                  ],
                )),
              ),
            ),
          ],
        ),
      ],
    );
  }

  

}

class AboutTile extends StatelessWidget {
  const AboutTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: BroadBandTheme.boxBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(Icons.account_circle, color: BroadBandTheme.iconColor,),
        title: Text(
          name[0].toUpperCase() + name.substring(1).toLowerCase(),
        ),
        subtitle: Text(email),
        onTap: () {},
      ),
    );
  }
}