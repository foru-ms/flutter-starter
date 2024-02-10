import 'package:flutter/material.dart';
import 'package:forum/models/commentModel.dart';
import 'package:forum/models/thread_model.dart';
import 'package:forum/services/api_service.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class ThreadCard extends GetView<ApiService> {
  ThreadModel thread;

  var totalPosts = 0.obs;

  ThreadCard(
    this.thread, {
    super.key,
  });

  Future<List<CommentModel>> getPostsByThreadId() async {
    final ApiService service = Get.find();
    final response = await service
        .getData("https://foru-ms.vercel.app/api/v1/thread/${thread.id}/posts");

    if (response.statusCode == 200) {
      // If the API call is successful, decode the JSON string
      final Map<String, dynamic> jsonData = response.body;
      // Extract the list of threads from the JSON data
      final List<dynamic> result = jsonData['posts'];
      // Now, map each JSON object in the list to ThreadModel
      List<CommentModel> data = result
          .map((json) => CommentModel.fromJson(json as Map<String, dynamic>))
          .toList();

      totalPosts.value = data.length;
      return data;
    } else {
      // If the API call fails, throw an exception or return an empty list
      throw Exception('Failed to load threads');
    }
  }

  @override
  Widget build(BuildContext context) {
    var posts = getPostsByThreadId();
    return GestureDetector(
      onTap: () {
        Get.toNamed('threadDetail',
            arguments: {"thread": thread, "posts": posts});
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        surfaceTintColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Container(
                width: 60,
                height: 60,
                child: Image.asset(
                  'asset/images/enrolled-student-8.png',
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(100),
                  ),
                ),
              ),
              title: Text('${thread.title}'),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'By ${thread.user?.username}',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  Text(
                    "${timeago.format(DateTime.parse(thread.createdAt.toString()))}",
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  // Text(
                  //   'In Marketing',
                  //   style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${thread.body}",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.comment),
                      label: Obx(() => Text("$totalPosts Comments")),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.comment),
                      label: Text("Last Comment by: ${thread.user?.username}"),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
