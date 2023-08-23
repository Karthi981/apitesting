import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {

  Future<http.Response>? _future;
  late TextEditingController _ctrl = new TextEditingController();

  Future<http.Response>AddCategory(String Description){
    return http.post(
        Uri.parse("http://catodotest.elevadosoftwares.com/Category/InsertCategory"),
    headers: <String , String>{
      'Content-Type' : 'application/json; charset=utf-8',
    },
      body: jsonEncode(<String , String>{
        "categoryId": "0",
        "category": "Tax Audit",
        "description": Description,
        "deletedOn": "",
        "removedRemarks": "",
        "createdBy": "3"
      }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: _future == null ? buildCol() : Respdata(),
          ),
        ],
      ),
    );
  }

  Column buildCol(){
    return Column(
      children: [
        TextFormField(
          controller: _ctrl,
        ),
        ElevatedButton(onPressed: (){
          setState(() {
            _future = AddCategory(_ctrl.text);
          });
        }, child: Text("Create Data")),
      ],
    );
  }

  FutureBuilder<http.Response>Respdata(){
    return FutureBuilder<http.Response>(
        future: _future,
        builder: (context ,snapshot ){
          if(snapshot.hasData){
            return Text(snapshot.data!.statusCode.toString()  == "200" ? "Added Successfully" : "Error " );
          }
          else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
            return CircularProgressIndicator();


        });
  }

}
