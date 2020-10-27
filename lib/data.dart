import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences prefs;

//   <span id="lblTotalData">Usage:317.43 MB</span></span>    //
String downSpeed = 'Test';
String upSpeed = 'Test';

bool remember = false;
bool check = true;
bool clicked = false;
int startIndex;
int endIndex;
int i = 0;
String hostname;
String url = 'https://selfcare.keralavisionisp.com/Customer/Default.aspx';
String url2 =
    'https://selfcare.keralavisionisp.com/Customer/PortalLogin.aspx?h8=1';
String url4 = 'https://selfcare.keralavisionisp.com/Customer/Gauge.aspx';

String slicedResponse;
String viewstate;
Color buttonColor = Color(0xff0A223f);
String viewstategenerator;
String eventvalidation;
String username;
String password;
String mobNumber;
String name;
String email = mobNumber;
String address;
String validityPeriod;
double currentUsage = 0.0;
double sessionUsage = 0.0;
String accountNum;
String plan;
String macAddress = 'Not Registered';

////////////////////////////// Maps ////////////////////////////////////////////
Map<String, dynamic> planMap;
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
