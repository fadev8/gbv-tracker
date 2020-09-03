import 'package:shared_preferences/shared_preferences.dart';


setRef(var key,String value) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key,value);
}

removeRef(var key) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}



getRef(var key) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value= await prefs.getString(key);

  return value;
}

Logout() async
{
  // remove login data
  await removeRef("user_names");
  await removeRef("user_category");
  await removeRef("user_id");
  await removeRef("user_names");
  await removeRef("user_category");
  await removeRef("user_district");
  await removeRef("user_sector");
}





