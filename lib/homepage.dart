import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  Icon(Icons.data_usage,color: Color(0xff555555),),
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
                      onPressed: null)
                ],
              ),
              SleekCircularSlider(
                initialValue: (double.parse(
                  currentUsage.substring(0, currentUsage.length - 3),
                )+double.parse(sessionUsage.substring(6,sessionUsage.length-3))),
                max: planMap['Limit'],
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
                            Text(
                              percentage.toStringAsFixed(2),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' GB',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black38),
                            )
                          ],
                        ),
                        Text('Used',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w300,
                                color: Colors.black38))
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
                        child: Column(
                          children: [
                            Text((planMap['Limit'] -double.parse(sessionUsage.substring(6,sessionUsage.length-3))-
                                    double.parse(currentUsage.substring(
                                        0, currentUsage.length - 3))).toStringAsFixed(2)
                                +' GB',textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20),),
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
                  Icon(Icons.link,color:Colors.black38),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      color: Color(0xffefefef),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
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
                  leading: Icon(Icons.account_circle),
                  title: Text(name[0].toUpperCase()+name.substring(1).toLowerCase()),
                  subtitle: Text(email),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
