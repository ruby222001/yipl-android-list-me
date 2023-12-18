import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newproject/models/post.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<Posts> posts = [];
  Future getPosts() async {
    var response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var jsonData = jsonDecode(response.body);
    for (var eachPost in jsonData) {
      final post = Posts(
        userId: eachPost['userId'],
        id: eachPost['id'],
        title: eachPost['title'],
        body: eachPost['body'],
      );
      posts.add(post);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 180, 110),
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Center(
            child: Text('Internship Challenges', style: TextStyle()),
          ),
        ),
        body: FutureBuilder(
            future: getPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: ListTile(
                            title: Text(posts[index].title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('User ID: ${posts[index].userId}'),
                                Text('ID: ${posts[index].id}'),
                                Text(posts[index].body),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
