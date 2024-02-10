import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forum/services/api_service.dart';
import 'package:get/get.dart';

class SignUp extends GetView<ApiService> {
  SignUp({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  // bool isChecked = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  create() async {
    final ApiService authService = Get.find();

    final data = {
      "username": usernameController.text,
      "email": emailController.text,
      "displayName": usernameController.text,
      "password": passwordController.text,
      "emailVerified": true,
      "roles": [""],
      "extendedData": {}
    };

    final response = await authService.postData(
      data,
      "https://foru-ms.vercel.app/api/v1/auth/register",
    );

    if (response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: "Registration successful!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0,
      );
      // Clear form fields
      usernameController.text = "";
      emailController.text = "";
      passwordController.text = "";
      confirmPasswordController.text = "";
      Get.back();
    } else if (response.status.hasError) {
      // Error during registration
      var result = response.body;
      print('Error: ${result['error']}');
      Fluttertoast.showToast(
        msg: "Error: ${result['error']}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  RxBool isChecked = false.obs;

  //
  var authService = Get.lazyPut(
    () async => ApiService(),
  ); // Initialize the authService instance lazily

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create an account"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Username", style: TextStyle(fontSize: 20)),
                SizedBox(
                  height: 10,
                ),
                //
                TextFormField(
                  controller: usernameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    hintText: "Username",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (String? value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Username is  required';
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Email",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),

                ///
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    hintText: "Email address",
                    labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  validator: (String? value) {
                    return (value != null && !value.contains('@'))
                        ? 'Email is  required'
                        : null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                //
                TextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    hintText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (String? value) {
                    return (value != null && value.length >= 6)
                        ? null
                        : 'Password is  required';
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Confirm Password",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: confirmPasswordController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.red, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    hintText: "Confirm password",
                    labelStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  validator: (String? value) {
                    return (value != null && value.length >= 6)
                        ? null
                        : 'Password is  required';
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Obx(
                      () => Checkbox(
                        value: isChecked.value,
                        tristate: true,
                        onChanged: (value) {
                          if (value != null)
                            isChecked.value = value;
                          else
                            isChecked.value = false;
                        },
                      ),
                    ),
                    Text(
                      "I accept the ",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Terms and Conditions',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.greenAccent,
                  child: MaterialButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        create();
                      } else {
                        if (isChecked.value == false)
                          // Show error message if validation fails
                          Fluttertoast.showToast(
                            msg: "Please accept Terms and Conditions",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                      }
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
