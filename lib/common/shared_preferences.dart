import 'package:shared_preferences/shared_preferences.dart';

getBySharedPreferences(String key) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString(key);
}
