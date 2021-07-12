import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Hello, ReqRes Users",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: FutureBuilder(
          builder: (context, projectSnap) {
            if (projectSnap.connectionState == ConnectionState.none ||
                projectSnap.connectionState == ConnectionState.waiting) {
              //print('project snapshot data is: ${projectSnap.data}');
              return Container(
                width: width,
                height: height,
                child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: projectSnap.data["data"].length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  alignment: Alignment.centerLeft,
                  width: width,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.7,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        child: Image.network(
                            projectSnap.data["data"][index]["avatar"],
                            width: 60,
                            height: 60),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            projectSnap.data["data"][index]["first_name"] +
                                " " +
                                projectSnap.data["data"][index]["last_name"],
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(projectSnap.data["data"][index]["email"],
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ))
                    ],
                  ),
                );
              },
            );
          },
          future: getData(),
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  Future getData() async {
    final response =
        await http.get('https://reqres.in/api/users?page=2', headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    var jsonBody = json.decode(response.body);
    return jsonBody;
  }

  @override
  void initState() {
    super.initState();
  }
}
