import 'dart:convert';

import 'package:api/Models/Details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/FakeImg.dart';

class Api3 extends StatefulWidget {
  const Api3({Key? key}) : super(key: key);

  @override
  State<Api3> createState() => _Api3State();
}

class _Api3State extends State<Api3> {
  
  Future<List<Images>>FetchImage()async{

   var resp = await http.get(Uri.parse("https://fakestoreapi.com/products"));

   var data =  jsonDecode(resp.body);

   return (data as List).map((e) => Images.fromJson(e)).toList();
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text("BattleStore",
          style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
      ),
      body: FutureBuilder< List<Images> >(
        future: FetchImage(),
        builder: (context , snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context , index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => Details(
                              snapshot.data![index].id.toString(),
                              snapshot.data![index].image.toString(),
                                snapshot.data![index].description.toString(),
                                snapshot.data![index].price.toString(),
                                snapshot.data![index].title.toString(),
                              snapshot.data![index].rating!.rate.toString()
                            ) ));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    snapshot.data![index].image.toString()),
                              fit: BoxFit.fill,
                          ),
                        ),
              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 100,
                          width: 260,
                          child: ListTile(
                            title: Text(snapshot.data![index].title.toString()),
                            subtitle: Text(snapshot.data![index].rating!.rate.toString()),
                            trailing: Text("\$ ${snapshot.data![index].price.toString()}"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
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
