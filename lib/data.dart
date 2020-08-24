import 'package:flutter/material.dart';
import 'package:internet_speed_test/internet_speed_test.dart';

String url = 'https://myaccount.keralavisionisp.com/Customer/Default.aspx';
String url2 =
    'https://myaccount.keralavisionisp.com/Customer/PortalLogin.aspx?h8=1';
String url3 =
    'https://myaccount.keralavisionisp.com/Customer/HomePage.aspx?Id=147205';

String url4 = 'https://myaccount.keralavisionisp.com/Customer/Gauge.aspx';

String url5 =
    'https://myaccount.keralavisionisp.com/Customer/Login.aspx?redir=true';

String slicedResponse;
int startIndex;
int endIndex;
int i = 0;
Map<String, String> body = {
  '__LASTFOCUS': '',
  'ToolkitScriptManager1_HiddenField': '',
  '__EVENTTARGET': '',
  '__EVENTARGUMENT': '',
  '__VIEWSTATE': viewstate,
  '__VIEWSTATEGENERATOR': viewstategenerator,
  '__EVENTVALIDATION': eventvalidation,
  'txtUserName': username,
  'txtPassword': password,
  'hdnloginwith': 'username',
  'save': 'Log In'
};
String viewstate;
Color buttonColor = Color(0xff0A223f);
String viewstategenerator;
String eventvalidation;
String username = 'Please Login';
String password = 'Please Login';
String mobNumber = 'Please Login';
String name = 'Please Login';
String email = 'Please Login';
String address = 'Please Login';
String validityPeriod = 'Please Login';
String currentUsage = 'Please Login';
String sessionUsage = 'Please Login';
String plan = 'Please Login';
Map<String, dynamic> planMap;
InternetSpeedTest internetSpeedTest;

String downSpeed = 'Test';
String upSpeed = 'Test';

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
      'Type': 'UL',
      'Speed': int.parse(data[1]),
      'Limit': 'NIL',
      'Validity': 'NIL'
    };

  return {
    'Type': 'UL',
    'Speed': int.parse(data[1]),
    'Limit': 'NIL',
    'Validity': 'NIL'
  };
}

Map<String, String> headers = {
  'Accept':
      'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
  'Accept-Encoding': 'gzip, deflate, br',
  'Accept-Language': 'en-US,en;q=0.9',
  'Cache-Control': 'max-age=0',
  'Connection': 'keep-alive',
  'Content-Length': '4529',
  'Content-Type': 'application/x-www-form-urlencoded',
  'Cookie': 'mIndex=0; ASP.NET_SessionId=wxy0bie2ks3v5a225bdalvqg',
  'Host': 'myaccount.keralavisionisp.com',
  'Origin': 'https://myaccount.keralavisionisp.com',
  'Referer': 'https://myaccount.keralavisionisp.com/Customer/Default.aspx',
  'Sec-Fetch-Dest': 'document',
  'Sec-Fetch-Mode': 'navigate',
  'Sec-Fetch-Site': 'same-origin',
  'Sec-Fetch-User': '?1',
  'Upgrade-Insecure-Requests': '1',
  'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36'
};
