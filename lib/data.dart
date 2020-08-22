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
  data.remove('M');
  data.remove('G');
  if (data.length == 3) {
    data.add('30');
  }

  return {
    'Type': data[0],
    'Speed': int.parse(data[1]),
    'Limit': double.parse(data[2]),
    'Validity': int.parse(data[3])
  };
}
