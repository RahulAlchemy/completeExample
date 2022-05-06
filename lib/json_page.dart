import 'dart:convert';


import 'package:flutter/material.dart';

import 'json_api.dart';
import 'json_model.dart';

class JsonDataPage extends StatefulWidget {
  const JsonDataPage({Key? key}) : super(key: key);

  @override
  _JsonDataPageState createState() => _JsonDataPageState();
}

class _JsonDataPageState extends State<JsonDataPage> {
  bool loading = true;
  Future<JsonModel>? _jsonModel;
  @override
  void initState() {
    _jsonModel = JsonApi().getJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: _jsonModel,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                //itemCount: json_Data == null ? 0 : json_Data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(""),
                      //subtitle: Text(json_Data[index]["body"]),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
