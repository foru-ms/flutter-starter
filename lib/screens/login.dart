import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forum/services/api_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;

  void login() async {
    setState(() {
      isLoading = true;
    });
    final ApiService authService = Get.find();

    final data = {
      "login": emailController.text,
      "password": passwordController.text,
    };
    final response = await authService.postData(
      data,
      "https://foru-ms.vercel.app/api/v1/auth/login",
    );
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      await prefs.setBool('loggedInOnce', true);
      await prefs.setString('token', response.body['token']);

      Fluttertoast.showToast(
        msg: "Login successful!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0,
      );

      Get.offNamed('home');
    } else {
      var result = response.body;
      print('Error: ${result}');
      Fluttertoast.showToast(
        msg: "Email or password is incorrect!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedInOnce = prefs.getBool('loggedInOnce') ?? false;

    if (loggedInOnce) {
      Get.offNamed('home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text("Username/Email", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      hintText: " username/name@company.com",
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
                    ),
                    validator: (String? value) {
                      return (value != null && !value.contains('@'))
                          ? 'Email is required'
                          : null;
                    },
                  ),
                  SizedBox(height: 20),
                  Text("Password", style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "password",
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
                    ),
                    validator: (String? value) {
                      return (value != null && value.length >= 6)
                          ? null
                          : 'Password is required';
                    },
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (_key.currentState!.validate()) {
                          login();
                        }
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              // Show loading indicator if isLoading is true
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : Text(
                              "Login",
                              style: TextStyle(fontSize: 20),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    child: Center(
                      child: Text(
                        'SignUp',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed('/signup');
                    },
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
