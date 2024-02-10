import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forum/components/comments.dart';
import 'package:forum/models/thread_model.dart';
import 'package:forum/services/api_service.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class ThreadDetail extends GetView {
  @override
  TextEditingController bodyController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool isLoading = false;
  RxBool isNew = false.obs;

  void ReplyPost({String? userId, String? threadId}) async {
    final ApiService service = Get.find();

    final response = await service.getUser();

    if (response.statusCode == 200) {
      final jsonData = response.body;

      if (jsonData != null) {
        final data = {
          "body": bodyController.text,
          "userId": userId,
          "threadId": threadId,
        };

        final response = await service.postData(
          data,
          "https://foru-ms.vercel.app/api/v1/post",
        );

        if (response.statusCode == 201) {
          Fluttertoast.showToast(
            msg: "Your reply was posted successfully!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          isNew.value = true;
          bodyController.text = "";
        } else {
          Fluttertoast.showToast(
            msg: "Failed to post reply. Please try again later.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          isNew.value = false;
        }
      }
    }
  }

  Widget build(BuildContext context) {
    ThreadModel thread = Get.arguments['thread'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Forum Thread'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${thread.title}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Container(
                  width: 60,
                  height: 60,
                  child: Image.asset(
                    'asset/images/enrolled-student-8.png',
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${thread.user!.username}",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(
                      "${timeago.format(DateTime.parse(thread.createdAt.toString()))}",
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${thread.body}"),
              ),

              // Text(
              //   "${thread.id}",
              //   //"Fusce placerat vel quam vel hendrerit. Suspendisse consequat fringilla dolor sed congue. Morbi mi ante",
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),

              Row(
                //mainAxisAlignment: MainAxisAlignment.,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'asset/images/enrolled-student-8.png',
                    ),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: bodyController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        maxLines: 2,
                        enabled: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (thread != null && thread.user != null) {
                                // Call ReplyPost method with userId and threadId
                                ReplyPost(
                                    userId: thread.user!.id,
                                    threadId: thread.id);
                              }
                            },
                            icon: Icon(Icons.send),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Reply to Rechel s post',
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueAccent, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Comments",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() => (isNew == true) ? Comments() : Comments()),

              // Divider(
              //   height: 30,
              // ),
              // Text(
              //   "Recent  Treads",
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              // ),
              // RecentThreads(),
              // RecentThreads(),
              // RecentThreads(),
              // RecentThreads(),
              // RecentThreads(),
              Divider(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
