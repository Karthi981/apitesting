import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/Entryclass.dart';


class Api2 extends StatefulWidget {
  const Api2({Key? key}) : super(key: key);

  @override
  State<Api2> createState() => _Api2State();
}

class _Api2State extends State<Api2> {

  Future<List<Entries>>Fetchentries()async{
    var resp = await http.get(Uri.parse("https://api.publicapis.org/entries"));

    var data = jsonDecode(resp.body)["entries"];

    return (data as List).map((e) => Entries.fromJson(e)).toList();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Entries")),
      ),
      body: FutureBuilder<List<Entries>>(
        future: Fetchentries(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder:(BuildContext context, index){
                  return ListTile(
                    title: Text(snapshot.data![index].aPI.toString()),
                    subtitle: Text(snapshot.data![index].description.toString()),
                    trailing: Icon(Icons.more_vert_outlined),
                  );
                }
            );
          }
          else if (snapshot.hasError) {
            return Column(
                children :[
                  const Icon(Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ]
            );
          }
          else {
            return Padding(
              padding: EdgeInsets.only(top: 48.0,left: 150),
              child: Column(
                  children :[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ]
              ),
            );
          }
        },
      ),
    );
  }
}
