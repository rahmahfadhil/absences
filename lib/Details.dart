import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'Date.dart';
import 'division.dart';
import 'names.dart';

class Details extends StatefulWidget {
  List<Date> list_date;

  String name;
  String stage4;
  String dev3;

  Details({ this.list_date,this.name,this.stage4,this.dev3});
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("Software Engineering"),
      ),
      body: ListView(
        children:[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: ()async{
              },
              child: Card(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 5,
                  child:ListTile(
                    title: Column(
                      children: [
                        Center(child: Text("${widget.name}",style: TextStyle(color: Colors.black, fontSize: 20),)),
                        Center(child: Text("${widget.stage4} : المرحلة",style: TextStyle(color: Colors.black, fontSize: 20),)),
                        Center(child: Text(" ${widget.dev3} :الشعبة ",style: TextStyle(color: Colors.black, fontSize: 20),)),
                      ],
                    ),
                    // subtitle: Center(child: Text("${widget.name}",style: TextStyle(color: Colors.black, fontSize: 20),)),
                    // leading: Center(child: Text("${widget.id_section}",style: TextStyle(color: Colors.black, fontSize: 20),)),
                  )
              ),
            ),
          ),
          GestureDetector(
            onTap: ()async{
            },
            child: ListTile(
              title:Align(
                  alignment: Alignment.bottomRight,
                  child: Text(" :تاريخ غياب الطالب ",style: TextStyle(color: Colors.black, fontSize: 20),)),
              // subtitle: Center(child: Text("${widget.name}",style: TextStyle(color: Colors.black, fontSize: 20),)),
              // leading: Center(child: Text("${widget.id_section}",style: TextStyle(color: Colors.black, fontSize: 20),)),
            ),
          ),

          Stack(
          alignment: Alignment.center,
          children: [

            Container(
              height: 600,
              child: ListView.builder(
                itemCount:widget.list_date.length,
                itemBuilder: (context, i) {
                  return Column(

                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: ()async{
                          },
                          child: Card(
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              elevation: 5,
                              child:ListTile(
                                title: Center(child: Text(widget.list_date[i].date,style: TextStyle(color: Colors.black, fontSize: 20),)),

                              )
                          ),
                        ),
                      ),



                    ],
                  );

                },
              ),
            ),


          ],
        ),

      ]
      ),
    );
  }
}
