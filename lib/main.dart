import 'dart:convert';

import 'package:fetch_api/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
List<PostModel> postList = [];

  Future<List<PostModel>> getPostApi () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      postList.clear();
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
      return postList;

    }else{
      return postList;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch the data'),
        centerTitle: true,
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getPostApi(),
                  builder:  (context, snapshot) {
                  if(!snapshot.hasData){
              return const Text('Loading...');
                  }else{
               return ListView.builder(
                itemCount: postList.length,
                itemBuilder:  (context, index) {
                 return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Title',style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.bold
                        ),),
                        Text(postList[index].title.toString()),

SizedBox(height: 10,),

                        Text('Description',style: TextStyle(fontSize: 15,
                        fontWeight: FontWeight.bold
                        ),),
                        Text(postList[index].body.toString()),
                      ],
                    ),
                  ));
               });
                  }
                }
                 ),
              )
              
            ],
          ),
      ),
      
    );
  }
}
