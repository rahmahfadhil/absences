import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;

import 'Listname.dart';

class NameOfAbsStud extends StatefulWidget {
  List<Listname> list;
  NameOfAbsStud({this.list});

  @override
  _NameOfAbsStudState createState() => _NameOfAbsStudState();
}

class _NameOfAbsStudState extends State<NameOfAbsStud> {
  String change="تعديل";
  bool delet=false;
  bool flag =false;
  bool pop_page=false;
  // var timer = Timer(Duration(seconds: 6),_loading);
  var icon=Icon(Icons.remove_circle,color: Colors.red);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: Text("Software Engineering"),
        ),
        body: ListView(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 570,
                  child: ListView.builder(
                    itemCount: widget.list.length,
                    itemBuilder: (context, i) {
                      return Center(

                        child: Column(

                          children: [
                            // list of  Absences student
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                key: Key(widget.list[i].id),
                                onTap: (){
                                },
                                child: Card(

                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0)),
                                  elevation: 5,
                                  child:ListTile(
                                    //leading:Text("${widget.list[i].id}",style: TextStyle(color: Colors.black, fontSize: 20),),
                                    title: Center(child: Text(widget.list[i].name,style: TextStyle(color: Colors.black, fontSize: 20),)),
                                    leading:Visibility(
                                        visible: delet,
                                        child: GestureDetector(
                                          onTap: (){

                                          },
                                          child: GestureDetector(
                                              onTap: ()async{
                                                setState(() {
                                                  flag=true;
                                                });
                                                //flag=true;
                                                pop_page=true;
                                                var url = 'https://vardevs.com/college/DELETE_absences.php';
                                                Map map={
                                                  "id_absences":"${widget.list[i].id}",
                                                };
                                                https.Response response = await https.post(url,body: map);
                                                if (response.body.trim()!='0') {
                                                  setState(() {
                                                    widget.list.removeAt(i);
                                                    flag=false;
                                                  }
                                                  );
                                                }

                                              },
                                              child: Icon(Icons.remove_circle,color: Colors.red,

                                              )
                                          ),
                                        )
                                    ),

                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  child: Visibility(child:
                  CircularProgressIndicator(
                    strokeWidth: 2.9,
                    backgroundColor: Colors.indigo,
                    valueColor: AlwaysStoppedAnimation(Colors.grey),
                  ),visible: flag,),
                ),
              ],
            ),
            Container(
              height: 45,
              width: 100,
              alignment: Alignment.center,
              child: Card(
                child: RaisedButton(onPressed: (){

                  if(change=="تعديل"){
                    setState(() {
                      change="تم";
                      delet=true;
                      //  flag=true;
                    });}
                  else
                  { setState(() {
                    change="تعديل";
                    delet=false;

                    // flag=true;

                  });}
                  if(pop_page==true){
                    setState(() {
                      Navigator.pop(context);
                    });
                  }
                },
                  ///////////////////////////////////////////////////////////
                  child:Text(change),
                  splashColor: Colors.red,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
