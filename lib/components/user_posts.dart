import 'package:flutter/material.dart';
import 'package:forum/models/commentModel.dart';
import 'package:forum/services/api_service.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserPosts extends GetView {
  UserPosts({super.key});

  Future<List<CommentModel>> getComments() async {
    final ApiService service = Get.find();
    final userResponse = await service.getUser();

    if (userResponse.statusCode == 200) {
      final user = userResponse.body;
      final response = await service.getData(
          "https://foru-ms.vercel.app/api/v1/posts?userId=${user['id']}");

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
    } else {
      throw Exception('Failed to load comments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getComments(),
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
          List<CommentModel>? comments = snapshot.data;
          return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments!.length,
              itemBuilder: (context, index) {
                CommentModel comment = comments[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Image.asset(
                          'asset/images/enrolled-student-8.png',
                        ),
                      ),
                      title: Text(
                        "${comment.user?.username}",
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
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${comment.body}"),
                    ),
                    Divider(),
                  ],
                );
              });
        }
      },
    );
  }
}
