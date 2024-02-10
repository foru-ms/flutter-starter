import 'package:flutter/material.dart';
import 'package:forum/models/thread_model.dart';
import 'package:get/get.dart';

class RecentThreads extends GetView {
  RecentThreads({super.key});

  @override
  Widget build(BuildContext context) {
    ThreadModel thread = Get.arguments['thread'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 60,
              height: 60,
              child: Image.asset(
                'asset/images/enrolled-student-8.png',
                fit: BoxFit.fill,
              ),
              decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.all(Radius.circular(100))),
            ),
            Text(
              "${thread.user!.username}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "58 solutions",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "220 appreciations",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}
