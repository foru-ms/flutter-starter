import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends GetConnect implements GetxService {
  // Example GET request
  Future<Response> getData(String? url) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 123',
      'x-api-key': '495c3a4d-2df1-4ea7-81bc-d82c9fd4c018'
    };

    return await get("$url", headers: headers);
  }

  Future<Response> postData(Map<String, dynamic> data, String? url) async {
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 123',
      'x-api-key': '495c3a4d-2df1-4ea7-81bc-d82c9fd4c018'
    };

    return await post(url, data, headers: headers);
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${prefs.getString('token').toString()}',
      'x-api-key': '495c3a4d-2df1-4ea7-81bc-d82c9fd4c018'
    };

    return await get("https://foru-ms.vercel.app/api/v1/auth/me",
        headers: headers);
  }
}
