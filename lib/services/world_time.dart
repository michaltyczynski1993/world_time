import 'dart:convert';
import 'package:http/http.dart';

class WorldTime {
  String location;
  String? time;
  String flag;
  String url; // location url for api endpoint

  WorldTime(
      {required this.location,
      this.time,
      required this.flag,
      required this.url});

  Future<void> getTime() async {
    //make the request
    var uri = Uri.https(
        'www.worldtimeapi.org', '/api/timezone/$url', {'q': '{http}'});
    Response response = await get(uri);
    Map data = jsonDecode(response.body);
    //print(response.body);

    //get data from API
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);

    //Create DateTime object
    DateTime now = DateTime.parse(datetime);
    now.add(Duration(hours: int.parse(offset)));

    //set property
    time = now.toString();
  }
}
