import
'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appfirstabceness/section.dart';


import 'package:http/http.dart' as https;

import 'AbsNumber.dart';
import 'Date.dart';
import 'Details.dart';

class Stud extends StatefulWidget {
  List<Section>list_section;
  List<AbsNumber> list;
  String id_material;
  String id_section;
  String stage3;
  String div2;
  Stud({this.list, this.id_section,this.id_material,this.list_section, this.stage3,this.div2});
  @override
  _StudState createState() => _StudState();
}

class _StudState extends State<Stud> {

  bool flag=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: Text("Software Engineering"),
        ),
        body:Stack(
            alignment: Alignment.center,
         children:[ ListView.builder(

            itemCount:widget.list.length,
            itemBuilder: (context, i) {

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: ()async{
                    setState(() {
                      print("div2");
                      print(widget.div2);
                      flag=true;

                    });
                    String url = 'https://vardevs.com/college/get_date_of_student.php';

                    Map map={
                      "id_student":"${widget.list[i].id}",
                      "id_material":widget.id_material,
                      "id_section":widget.id_section
                    };

                    https.Response response = await https.post(url,body: map);
                    if (response.body.trim()!='0') {


                      String str = utf8.decode(response.bodyBytes);
                      List json1 = jsonDecode(str);
                      List <Date>list1 = List();
                      json1.forEach((element) {
                        list1.add(Date(element));
                      }
                      );

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return Details(
                              list_date: list1,
                              name: widget.list[i].name,
                              stage4:widget.stage3,
                              dev3:widget.div2,

                            );
                          }
                          ));

                    }
                    setState(() {
                      flag=false;
                    });


                  },
                  child: Card(
                      color: int.parse(widget.list[i].day)*2>=4&&int.parse(widget.list[i].day)*2<6?Colors.amber:
                      int.parse(widget.list[i].day)*2>=6?Colors.red:Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      elevation: 5,


                      child:ListTile(
                        title: Center(child: Text("${widget.list[i].name}",style: TextStyle(color: Colors.black, fontSize: 20),)),
                        trailing:Column(

                          children: [

                            Text(":ساعات الغياب ",style: TextStyle(color: Colors.black, fontSize: 10),),
                            Text("${int.parse(widget.list[i].day)*2}",style: TextStyle(color: Colors.black, fontSize: 20),),
                            // Text("${widget.list[i].day}",style: TextStyle(color: Colors.black, fontSize: 20),),
                          ],
                        ),
                      )
                  ),
                ),
              );
            },
          ),
           Visibility(child: CircularProgressIndicator(
             backgroundColor: Colors.indigo,
             strokeWidth: 2.9,
             valueColor: AlwaysStoppedAnimation(Colors.grey),
           ),visible: flag,)
      ]
        )
    );
  }
}
