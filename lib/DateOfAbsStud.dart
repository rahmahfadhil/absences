import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as https;
import 'Date.dart';
import 'Listname.dart';
import 'NameOfAbsStud.dart';

class DateOfAbsStud extends StatefulWidget {

  List<Date> list;
  String id_material;
  String id_section;
  DateOfAbsStud({this.list,this.id_section,this.id_material});

  @override
  _DateOfAbsStudState createState() => _DateOfAbsStudState();
}
class _DateOfAbsStudState extends State<DateOfAbsStud> {
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
        children: [
          ListView.builder(
            itemCount: widget.list.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: ()async{
                    setState(() {
                      flag=true;
                    });
                    var url = 'https://vardevs.com/college/get_absences.php';

                    Map map={
                      "date":"${widget.list[i].date}",
                      "id_material":widget.id_material,
                      "id_section":widget.id_section
                    };
                    https.Response response = await https.post(url,body: map);
                    if (response.body.trim()!='0') {

                      String str = utf8.decode(response.bodyBytes);
                      List json1 = jsonDecode(str);
                      List <Listname>list1 = List();
                      json1.forEach((element) {
                        list1.add(Listname(element));
                      }
                      );

                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return NameOfAbsStud(list: list1,);
                          }
                          ));
                      setState(() {
                        flag=false;
                      });
                    }
                  },
                  child: Card(
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      elevation: 5,
                      child:ListTile(
                        title: Center(child: Text(widget.list[i].date,style: TextStyle(color: Colors.black, fontSize: 20),)),
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
        ],
      ),
    );
  }
}
