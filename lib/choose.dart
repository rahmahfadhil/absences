import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';


import 'package:http/http.dart' as ht;
import 'package:http/http.dart' as https;
import 'AbsNumber.dart';
import 'Date.dart';
import 'DateOfAbsStud.dart';
import 'Stud.dart';
import 'Student List.dart';
import 'names.dart';

class Choose extends StatefulWidget {
  String id;
  String id_material;
  String stage2;
  String div1;
  Choose({this.id, this.id_material,this.stage2,this.div1});

  @override
  _ChooseState createState() => _ChooseState();

}

class _ChooseState extends State<Choose> {
  bool flag =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: Text("Software Engineering"),
        ),
        body: Stack(
            alignment: Alignment.center,
            children:[ ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 30, 50, 50),
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              width: 200,
                              height: 200,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white70,
                                  image: DecorationImage(
                                      image: AssetImage('images/flutter.png'),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            padding: EdgeInsets.all(0.0),
                            width: 200,
                            height: 50,
                            child: Center(
                                child: (Text(
                                  "Choose :",
                                  style: TextStyle(color: Colors.black, fontSize: 30),
                                ))),
                            alignment: Alignment.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                flag=true;
                              });
                              var url =
                                  'https://vardevs.com/college/get_students.php';
                              Map map = {"id": "${widget.id}"};
                              ht.Response response =
                              await ht.post(url, body: map);
                              if(response.body.trim()!='0'){
                                String str = utf8.decode(response.bodyBytes);
                                List json = jsonDecode(str);
                                List<Names> list = List();
                                json.forEach((element) {
                                  list.add(Names(element));
                                });
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return StudentList(
                                    list: list,
                                    id_stage: widget.id,
                                    id_material: widget.id_material,
                                  );

                                }));}
                              setState(() {
                                flag =false;
                              });
                            },

                            child: Card(
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              elevation: 5,
                              child: Container(  padding: EdgeInsets.all(8.0),
                                  width: 250,
                                  height: 60,

                                  child: Center(child: Text("قوائم الطلاب",style: TextStyle(fontSize: 20),),)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(25.0),
                          child: GestureDetector(
                            onTap: () async {
                              setState(() {
                                flag=true;
                              });
                              var url =
                                  'https://vardevs.com/college/get_date.php';
                              Map map = {
                                "id_material": widget.id_material,
                                "id_section": widget.id
                              };

                              https.Response response =
                              await https.post(url, body: map);
                              if (response.body.trim() != '0') {
                                String str = utf8.decode(response.bodyBytes);
                                List json = jsonDecode(str);

                                List<Date> list = List();
                                json.forEach((element) {
                                  list.add(Date(element));
                                });
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return DateOfAbsStud(
                                        list: list,
                                        id_section: widget.id,
                                        id_material: widget.id_material,
                                      );
                                    }));
                              }
                              setState(() {
                                flag=false;
                              });
                            },

                            child: Card(
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              elevation: 5,
                              child: Container(  padding: EdgeInsets.all(8.0),
                                width: 250,
                                height: 60,
                                child: Center(child: Text("قوائم الغياب",style: TextStyle(fontSize: 20),)),),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(25.0),
                          child:   GestureDetector(
                            onTap: () async {
                              setState(() {
                                print("div");
                                print(widget.div1);
                                flag=true;
                              });
                              var url =
                                  'https://vardevs.com/college/get_students_absences.php';
                              Map map = {
                                "id_material": widget.id_material,
                                "id_section": widget.id
                              };
                              ht.Response response =
                              await ht.post(url, body: map);
                              if(response.body.trim()!='0'){
                                String str = utf8.decode(response.bodyBytes);
                                List json = jsonDecode(str);
                                List<AbsNumber> list = List();
                                json.forEach((element) {
                                  list.add(AbsNumber(element));
                                });
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return Stud(
                                    list: list,
                                    id_section: widget.id,
                                    id_material: widget.id_material,
                                    stage3:widget.stage2,
                                 div2: widget.div1,
                                  );

                                }));}
                              setState(() {
                                flag =false;
                              });
                            },

                            child: Card(
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              elevation: 5,
                              child: Container(  padding: EdgeInsets.all(8.0),
                                  width: 250,
                                  height: 60,

                                  child: Center(child: Text("الغياب",style: TextStyle(fontSize: 20),),)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              Visibility(child: CircularProgressIndicator(
                backgroundColor: Colors.indigo,
                strokeWidth: 2.9,
                valueColor: AlwaysStoppedAnimation(Colors.grey),
              ),visible: flag,)
            ] ));
  }
}
