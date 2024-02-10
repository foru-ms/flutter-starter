import 'dart:async'; // Import dart:async for Timer

import 'package:flutter/material.dart';
import 'package:forum/components/read_threads.dart';
import 'package:forum/screens/create_thread.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isloading = false;
  @override
  Future<void> _logout() async {
    setState(() {
      isloading = true;
    });
    // Clear user session data
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to login screen
    Get.offNamed('login');
    (Route<dynamic> route) =>
        false; // Prevents user from going back to home ssscreen
  }

  Future<void> _refreshContent() async {
    // Implement the logic to refresh content here
    // For example, fetch updated data from the server
    setState(() {
      CreateThread();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forum"),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed('createThread');
            },
            tooltip: "Create Thread",
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
            child: ListView(
              //   padding: EdgeInsets.zero,
              children: <Widget>[
                //DrawerHeader(child: Icon(Icons.menu)),

                ListTile(
                  leading: Icon(Icons.add_to_home_screen),
                  title: Text('Home'),
                  onTap: () {
                    Get.toNamed('/home');
                  },
                ),
                ListTile(
                  leading: Icon(Icons.image),
                  title: Text('Profile'),
                  onTap: () {
                    Get.toNamed('profile');
                  },
                ),
                ListTile(
                  leading: isloading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            // Show loading indicator if isLoading is true
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                          ),
                        )
                      : Icon(Icons.logout),
                  title: Text('logout'),
                  onTap: () {
                    _logout();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshContent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Search for threads & posts",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 2)),
                  child: ListTile(
                    leading: Icon(
                      Icons.search,
                      size: 25,
                    ),
                    title: TextField(
                      keyboardType: TextInputType.none,
                      decoration: InputDecoration(
                          hintText: 'Search', border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // List
                Container(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFDEFFFF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Recent Threads'),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {},
                            child: Text('Unanswered Threads'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ReadThreads(),
                Divider(
                  height: 30,
                ),
                // Text(
                //   "Recent Posts",
                //   style: TextStyle(fontSize: 20),
                // ),
                //RecentPosts(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
