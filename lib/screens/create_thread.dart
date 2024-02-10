import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forum/models/user_model.dart';
import 'package:forum/services/api_service.dart';
import 'package:get/get.dart'; // Make sure to import PosteThreadService if needed

class CreateThread extends StatefulWidget {
  const CreateThread({super.key});

  @override
  State<CreateThread> createState() => _CreateThreadState();
}

class _CreateThreadState extends State<CreateThread> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;

  void create() async {
    setState(() {
      isLoading = true; // Set isLoading to true when the button is pressed
    });

    // Corrected data format for post request
    final ApiService service = Get.find();

    final response = await service.getUser();

    if (response.statusCode == 200) {
      final jsonData = response.body;

      if (jsonData != null) {
        UserModel user = UserModel.fromJson(jsonData as Map<String, dynamic>);
        String slug = titleController.text.replaceAll(" ", '-').toLowerCase();
        final data = {
          "title": titleController.text,
          "body": bodyController.text,
          "slug": slug,
          "userId": user.id,
          "locked": false,
          "pinned": false,
        };

        // You should replace this URL with your actual endpoint for posting threads
        final response = await service.postData(
          data,
          "https://foru-ms.vercel.app/api/v1/thread",
        );
        if (response.statusCode == 201) {
          Fluttertoast.showToast(
            msg: "Your thread created!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          setState(() {
            isLoading =
                true; // Set isLoading back to false after create function completes
          });

          titleController.text = "";
          bodyController.text = "";
        }
      }
    } else if (response.statusCode == 401) {
      Fluttertoast.showToast(
        msg: "Unauthorized access",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.amber,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      setState(() {
        isLoading =
            false; // Set isLoading back to false after create function completes
      });
    } else {
      Fluttertoast.showToast(
        msg: "Error: ${response.body['error']}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        isLoading =
            false; // Set isLoading back to false after create function completes
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Thread"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller:
                        titleController, // Assign controller to TextField
                    decoration: InputDecoration(
                      hintText: 'Thread title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      return (value != null && value.isNotEmpty)
                          ? null
                          : 'please fill out this field';
                    },
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Body',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  TextFormField(
                    controller:
                        bodyController, // Assign controller to TextField
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: 'Thread body ......',
                      border: OutlineInputBorder(),
                    ),
                    validator: (String? value) {
                      return (value != null && value.isNotEmpty)
                          ? null
                          : 'please fill out this field';
                    },
                  ),
                  SizedBox(height: 16.0),
                  MaterialButton(
                    color: Colors.green,
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        create(); // Call create function
                      }
                    },
                    child: Center(
                      child: isLoading
                          ? CircularProgressIndicator(
                              // Show loading indicator if isLoading is true
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            )
                          : Text('Submit post'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
