import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appfirstabceness/section.dart';

import 'package:http/http.dart' as https;

//import 'Section.dart';
import 'division.dart';
import 'thedivision.dart';
class TheStages extends StatefulWidget {
  List<Section>lists;
  String id_material;
  //String stage;
  TheStages({this.lists,this.id_material});

  @override
  _TheStagesState createState() => _TheStagesState();
}

class _TheStagesState extends State<TheStages> {
  String stage;
  bool str=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: Text('Sowftware Engineer',
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            ListView.builder(itemCount: 1,itemBuilder: (context, i) {
              return
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 30, 50, 50),
                      child: Container(
                          padding: EdgeInsets.all(16.0),
                          width: 200,
                          height: 200,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white70,
                              image: DecorationImage(
                                  image: AssetImage('images/flutter.png'),
                                  fit: BoxFit.fill),
                              shape: BoxShape.circle)),
                    ),

                    Center(child: Text('choose the stage',style: TextStyle(fontSize:35,),)),


                    Container(
                      height:300,
                      width: MediaQuery.of(context).size.width/1.5,
                      alignment: Alignment.center,
                      child:ListView.builder(itemCount: widget.lists.length,itemBuilder: (context, i) {
                        return Padding(padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(

                            onTap: ()async{

                              setState(() {
                                stage=widget.lists[i].stage;

                                str=true;
                              });
                              String url='https://vardevs.com/college/get_section.php';

                              Map map={
                                'id_stage':'${widget.lists[i].id_stage}',
                              };
                              https.Response response=await https.post(url,body: map);
                              if (response.body.trim()!='0'){


                                String str=utf8.decode(response.bodyBytes);
                                List json=jsonDecode(str);
                                List <Division> list=List();
                                json.forEach((element) {
                                  list.add(Division(element));
                                });

                                print(widget.id_material);
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){

                                  return TheDivision(list: list,id_Stage: widget.lists[i].id_stage,id_material: widget.id_material,stage1:stage)   ;
                                }));

                              }
                              setState(() {
                                str=false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(12.0) ),
                                color: Colors.white70,
                                elevation: 5,
                                child: ListTile(
                                  title: Center(child: Text(widget.lists[i].stage)),
                                ),

                              ),
                            ),

                          ),


                        );
                      },) ,

                    ),
                  ],
                );
            },),
            Visibility(child: CircularProgressIndicator(
              strokeWidth: 2.9,
              backgroundColor: Colors.indigo,
              valueColor: AlwaysStoppedAnimation(Colors.grey),
            ),visible: str)
          ],
        )
    );
  }
}