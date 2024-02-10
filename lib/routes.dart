import 'package:forum/screens/create_thread.dart';
import 'package:forum/screens/home.dart';
import 'package:forum/screens/login.dart';
import 'package:forum/screens/profile.dart';
import 'package:forum/screens/signup.dart';
import 'package:forum/screens/thread_detail.dart';
import 'package:get/get.dart';

get routes => <GetPage>[
      GetPage(name: '/login', page: () => Login()),
      GetPage(name: '/signup', page: () => SignUp()),
      GetPage(name: '/threadDetails', page: () => SignUp()),
      GetPage(name: '/profile', page: () => Profile()),
      GetPage(name: '/createThread', page: () => CreateThread()),
      GetPage(name: '/home', page: () => Home()),
      GetPage(name: '/threadDetail', page: () => ThreadDetail()),
    ];
