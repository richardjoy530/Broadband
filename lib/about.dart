import 'package:flutter/material.dart';

import 'data.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'This is an experimental App',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w300, color: BroadBandTheme.secondaryFontColor),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: BroadBandTheme.boxBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(Icons.email, color: BroadBandTheme.iconColor),
                  title: Text('richardjoy530@gmail.com'),
                  subtitle: Text('Developer'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
