import 'package:flutter/material.dart';
import 'package:forum/components/thread_card.dart';
import 'package:forum/models/thread_model.dart';
import 'package:forum/services/api_service.dart';
import 'package:get/get.dart';

class ReadThreads extends StatelessWidget {
  ReadThreads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getThreads(),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          List<dynamic> threads = snapshot.data ?? [];
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(), // Disables scrolling
            shrinkWrap: true,
            itemCount: threads.length,
            itemBuilder: (context, index) {
              ThreadModel thread = threads[index];

              return ThreadCard(thread);

              // You can pass data to ThreadCard using threads[index]
            },
          );
        }
      },
    );
  }

  Future<List<ThreadModel>> getThreads() async {
    final ApiService service = Get.find();
    final response =
        await service.getData("https://foru-ms.vercel.app/api/v1/threads");

    if (response.statusCode == 200) {
      // If the API call is successful, decode the JSON string
      final Map<String, dynamic> jsonData = response.body;
      // Extract the list of threads from the JSON data
      final List<dynamic> threadsData = jsonData['threads'];
      // Now, map each JSON object in the list to ThreadModel
      List<ThreadModel> data = threadsData
          .map((json) => ThreadModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return data;
    } else {
      // If the API call fails, throw an exception or return an empty list
      throw Exception('Failed to load threads');
    }
  }
}
