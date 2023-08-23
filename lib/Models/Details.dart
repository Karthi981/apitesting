import 'package:flutter/material.dart';

import '../textstyle.dart';

class Details extends StatefulWidget {
  final String Title;
  final String Price;
  final String Description;
  final String prodId;
  final String image;
  final String Rating;
  Details(
      this.prodId,
      this.image,
      this.Description,
      this.Price,
      this.Title,
      this.Rating);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.prodId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Center(child: Text("Products",)),
      ),
      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text(widget.Title,style: bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: NetworkImage(widget.image),
                    fit: BoxFit.fill
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,bottom: 8.0),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Description:",style: Big,)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,bottom: 8,right:16 ),
              child: Text(widget.Description,
                style: TextStyle(wordSpacing: 5),
                textAlign: TextAlign.justify,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Price : \$${widget.Price}",style: Big,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  children: [
                    Icon(Icons.star),
                    SizedBox(width: 10,),
                    Text("Rating: ${widget.Rating}",style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            )

          ],
        ),
      ),

    );
  }
}

