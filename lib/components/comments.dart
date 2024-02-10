import 'package:flutter/material.dart';
import 'package:forum/models/commentModel.dart';
import 'package:forum/models/thread_model.dart';
import 'package:forum/services/api_service.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class Comments extends GetView {
  Comments({super.key});

  Future<List<CommentModel>> getPostsByThreadId() async {
    final ApiService service = Get.find();
    ThreadModel threadModel = Get.arguments['thread'];

    final response = await service.getData(
        "https://foru-ms.vercel.app/api/v1/thread/${threadModel.id}/posts");
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = response.body;
      final List<dynamic> result = jsonData['posts'];
      List<CommentModel> data = result
          .map((json) => CommentModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  Future<Map<String, dynamic>> getUserData(String? id) async {
    final ApiService service = Get.find();
    final response =
        await service.getData("https://foru-ms.vercel.app/api/v1/user/${id}");

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return Map();
      // throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPostsByThreadId(),
      builder: (context, AsyncSnapshot<List<CommentModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              width: 100,
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<CommentModel> comments = snapshot.data ?? [];

          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (context, index) {
              CommentModel comment = comments[index];

              return FutureBuilder(
                future: getUserData(comment.userId),
                builder: (context,
                    AsyncSnapshot<Map<String, dynamic>> userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: Colors.red,
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    );
                  } else if (userSnapshot.hasError) {
                    return Text('Error: ${userSnapshot.error}');
                  } else {
                    final userData = userSnapshot.data!;
                    final username = userData['username'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                            ),
                            child: Image.asset(
                              'asset/images/enrolled-student-8.png',
                            ),
                          ),
                          title: Text(
                            username,
                            style: TextStyle(fontSize: 20),
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Manager",
                                style: TextStyle(fontSize: 15),
                              ),
                              Text(
                                "${timeago.format(DateTime.parse(comment.createdAt.toString()))}",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                              ),
                            ],
                          ),
                        ),
                        Text("${comment.body}"
                            // Add your text style here
                            ),
                        Row(
                          children: [
                            Text("like"),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Reply"),
                            ),
                            Text("View replies"),
                          ],
                        ),
                        Divider(),
                      ],
                    );
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
