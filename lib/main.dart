import 'dart:convert';

import 'package:api_example_239/data_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataModel? mQuotes;

  @override
  void initState() {
    super.initState();
    getQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quotes')),
      body: mQuotes != null
          ? mQuotes!.quotes!.isNotEmpty
              ? ListView.builder(
        itemCount: mQuotes!.quotes!.length,
          itemBuilder: (_, index){
                return ListTile(
                  title: Text('${mQuotes!.quotes![index].quote}'),
                  subtitle: Text('${mQuotes!.quotes![index].author}'),
                );
      })
              : Center(
                  child: Text('No Quotes found!!'),
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void getQuotes() async {
    String url = "https://dummyjson.com/quotes";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var mData = response.body;
      print(mData);

      var rawData = jsonDecode(mData);

      mQuotes = DataModel.fromJson(rawData);
      setState(() {});
    }
  }
}
