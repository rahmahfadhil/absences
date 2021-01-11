import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as ht;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'names.dart';


class StudentList extends StatefulWidget {
  List<Names> list;
  String id_material;
  String id_stage;
  List<bool> listOfcheck = List();
  List<String> listofid = List();
  String id;
  StudentList({this.list, this.id, this.id_stage,this.id_material,});

  // StudentList({this.list2});
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  bool flag=false;
  bool checkbox = true;
  DateTime _dateTime;
  String date = DateTime.now().toString();
  TimeOfDay time;
  TimeOfDay picked;

  TextEditingController controller = TextEditingController();
  var done = Icon(Icons.check, color: Colors.white);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.list.length; i++) {
      widget.listOfcheck.add(true);
    }
    time = TimeOfDay.now();
  }

  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: time);
    if (picked != null) {
      setState(() {
        time = picked;
      });
    }
  }

  Widget build(BuildContext context) {
    List list = widget.listofid.map((v) => {'id': v}).toList();
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
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: Card(
                    margin: EdgeInsets.fromLTRB(40, 10, 40, 10),
                    elevation: 5,
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2019),
                              lastDate: DateTime(2022),
                            ).then((value) {
                              setState(() {
                                _dateTime = value;
                                String time = _dateTime.toString();
                                date = time.substring(0, 10);
                              });
                            });
                          },
                        ),
                        subtitle: Text("${time.hour}:${time.minute}",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                        trailing: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () {
                            selectTime(context);
                          },
                        ),
                        title: Text(
                          "${date.substring(0, 10)}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.7,
                      child: ListView.builder(
                          itemCount: widget.list.length,
                          itemBuilder: (context, i) {
                            return Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12.0)),
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 0),
                                          child: Center(
                                            child: ListTile(
                                              trailing: Text("_${widget.list[i].id}"),
                                              leading: Checkbox(
                                                  value: widget.listOfcheck[i],
                                                  onChanged: (bool value) {
                                                    setState(() {
                                                      if (widget.listOfcheck[i]) {
                                                        widget.listofid
                                                            .add(widget.list[i].id);
                                                      }

                                                      widget.listOfcheck[i] =
                                                      !widget.listOfcheck[i];
                                                    });
                                                  }),
                                              title: Center(
                                                  child: Text(widget.list[i].name)),
                                            ),
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 17,
                        width: MediaQuery.of(context).size.width / 4,
                        child: RaisedButton(
                          onPressed: () async {
                            flag=true;
                            setState(() {

                            });
                            var url = 'https://vardevs.com/college/add_absences.php';
                            Map map = Map();

                            map['id_student'] = jsonEncode(list);
                            map['date'] = date.substring(0, 10);
                            map['id_material'] = widget.id_material;
                            map['id_section'] = widget.id_stage;
                            print(map);
                            ht.Response response = await post(url, body: map);
                            if (response.body.trim() != '0') {
                              setState(() {
                                done = Icon(Icons.check, color: Colors.green,size: 25,);
                              });
                            }
                            if(map!=null)
                            {

                              Navigator.pop(context,map);
                            }
                          },
                          child: Text(
                            "تم",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Color(0xFF728FCE),
                          elevation: 5,
                          splashColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      )),
                ),

                Center(
                  child: done,
                ),
                Visibility(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.indigo,
                    minHeight: 3.0,
                    valueColor: AlwaysStoppedAnimation(Colors.grey),
                  ),
                ),visible: flag,)
              ]
          )),
    );
  }
}
