import 'package:flutter/material.dart';
import 'package:forum/components/user_posts.dart';
import 'package:forum/models/user_model.dart';
import 'package:forum/services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends GetView<ApiService> {
  Profile({super.key});
  var user = UserModel().obs;
  getProfildData() async {
    final ApiService service = Get.find();

    final response = await service.getUser();

    if (response.statusCode == 401) {
      // Clear user session data
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // Navigate to login screen
      Get.offNamed('login');
      (Route<dynamic> route) =>
          false; // Prevents user from going back to home ssscreen
    }

    if (response.statusCode == 200) {
      final jsonData = response.body;

      UserModel data = UserModel.fromJson(jsonData as Map<String, dynamic>);
      user.value = data;
      return user;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  @override
  Widget build(BuildContext context) {
    getProfildData();
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details "),
        leading: IconButton(
          onPressed: () {
            Get.offNamed('home');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Image.asset(
                        'asset/images/beautiful.jpg',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 280,
                      ),
                    ),
                    Positioned(
                      top: 220,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                            border: Border.all(color: Colors.grey, width: 4)),
                        child: Image.asset(
                          "asset/images/enrolled-student-8.png",
                          //   ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                  child: Obx(
                () => Text(
                  "${(user.value.username != null) ? user.value.username : ''}",
                  style: TextStyle(
                    fontSize: 24, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Marketing Expert",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "${(user.value.bio != null) ? user.value.bio : 'No Bio'}",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 200,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Available",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Center(
              //   child: Container(
              //     width: 300,
              //     height: 50,
              //     child: Center(
              //       child: Text(
              //         "Follow",
              //         style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 20,
              //         ),
              //       ),
              //     ),
              //     decoration: BoxDecoration(
              //         border: Border.all(color: Colors.black, width: 3)),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Recent posts by you",
                style: TextStyle(fontSize: 25),
              ),
              Divider(),
              UserPosts(),
            ],
          ),
        ),
      ),
    );
  }
}
