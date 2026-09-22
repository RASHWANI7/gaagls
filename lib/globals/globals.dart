import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

class Globals{

  final String ip='172.16.40.9:8000';
  final String ngrok='https://552c9092d1ad.ngrok-free.app';

  Future<void> saveTokenAndCityId({required String token,required int city_id}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.Access_Token, token);
    await prefs.setInt(Constants.Access_CityId, city_id);
  }

  Future<void> saveUserId({required int user_id}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(Constants.Access_UserId, user_id);
  }


  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(Constants.Access_Token);
    return token;
  }

  Future<int?> getCityId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? city_id = prefs.getInt(Constants.Access_CityId);
    return city_id;
  }

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? user_id = prefs.getInt(Constants.Access_UserId);
    return user_id;
  }

  Future<void> deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.Access_Token);
  }

  Future<void> deleteCityId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.Access_CityId);
  }

  ///////////////////////////////////////////////////////////////////


  static String convertTime(String time24) {
    List<String> parts = time24.split(":");
    int hour = int.parse(parts[0]);
    String minute = parts[1];
    String second = parts[2];

    String period = hour >= 12 ? "PM" : "AM";
    int hour12 = hour % 12;
    if (hour12 == 0) {
      hour12 = 12;
    }
    String hourStr = hour12 < 10 ? "0$hour12" : "$hour12";
    return "$hourStr:$minute:$second $period";
  }


  static String convertTime12to24(String time12) {
    // إزالة الفراغات الزائدة
    time12 = time12.trim();

    // فصل الوقت عن فترة اليوم (AM/PM)
    List<String> parts = time12.split(RegExp(r'\s+'));
    String timePart;
    String meridiem;

    if (parts.length >= 2) {
      timePart = parts[0];
      meridiem = parts[1].toUpperCase();
    } else {
      // في حال كانت الفترة ملحقة بالنهاية بدون مسافة
      if (time12.toUpperCase().endsWith("AM")) {
        timePart = time12.substring(0, time12.length - 2);
        meridiem = "AM";
      } else if (time12.toUpperCase().endsWith("PM")) {
        timePart = time12.substring(0, time12.length - 2);
        meridiem = "PM";
      } else {
        // لا يمكن تحديد الفترة زمنية
        throw FormatException("صيغة الوقت غير صحيحة");
      }
    }

    // تقسيم الوقت إلى مكوناته (ساعة:دقيقة)
    List<String> timeComponents = timePart.split(":");
    if (timeComponents.length < 2) {
      throw FormatException("صيغة الوقت غير صحيحة");
    }

    int hour = int.parse(timeComponents[0]);
    int minute = int.parse(timeComponents[1]);

    // تحويل الساعة بناءً على الفترة الزمنية
    if (meridiem == "AM") {
      if (hour == 12) {
        hour = 0;
      }
    } else if (meridiem == "PM") {
      if (hour != 12) {
        hour += 12;
      }
    } else {
      throw FormatException("تحديد الفترة الزمنية غير صحيح (يجب أن يكون AM أو PM)");
    }

    // تنسيق الساعات والدقائق بأرقام ذات خانتين
    String hourStr = hour.toString().padLeft(2, '0');
    String minuteStr = minute.toString().padLeft(2, '0');

    return "$hourStr:$minuteStr";
  }



}