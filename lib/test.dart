import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List posts = [];

  Future getPost() async {
    String url = "https://jsonplaceholder.typicode.com/posts";

    var response = await http.get(Uri.parse(url));

    var responsebody = jsonDecode(response.body);

    setState(() {
      posts.addAll(responsebody);
    });
  }

  @override
  void initState() {
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, i) {
          return posts == null || posts.isEmpty
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Text(
                  "${posts[i]['title']}",
                  style: TextStyle(fontSize: 12, color: Colors.blueAccent),
                );
        });
  }
}
