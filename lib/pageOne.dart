import 'dart:convert';

import 'package:random_words/random_words.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (BuildContext context, int index) { return Card();});


  }

  Row Card() {
    String word = WordNoun.random().toString();
    return Row(children: <Widget>[Text(word,style: TextStyle(fontSize: 25)),
      FutureBuilder<dynamic>(
          future: FindImage(word),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Image.network(snapshot.data!,   height: 100, width: 100,);
            } else if (snapshot.hasError) {
              return Tab(icon: new Icon(Icons.error));
            } else {
              return const CircularProgressIndicator();
            }
          })

    ]);
  }

  Future<String> FindImage(String word) async {
    final queryParameters = {
      "action": "query",
      "format": "json",
      "titles": word,
      "prop": "images",
      "imlimit": "1",
       "prop" : "pageimages",

    };
    final uri = Uri.https('en.wikipedia.org', '/w/api.php', queryParameters);
    final response = await http.get(uri, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers": "Content-Type",
      "Referrer-Policy": "no-referrer-when-downgrade"
    });
    final decoded = jsonDecode(response.body);
    JsonEncoder encoder = new JsonEncoder.withIndent('  ');
    String imageUrl = decoded["query"]["pages"].values.first["thumbnail"]["source"];
    return imageUrl;
  }
}
