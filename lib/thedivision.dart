import 'package:flutter/material.dart';
import 'choose.dart';
import 'division.dart';
class TheDivision extends StatefulWidget {
  List<Division>list;
  String id_Stage;
  String stage1;
  String id_material;
  TheDivision({this.list,this.id_Stage,this.id_material,this.stage1});
  @override
  _TheDivisionState createState() => _TheDivisionState();
}

class _TheDivisionState extends State<TheDivision> {
  String div;
  bool flag=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          centerTitle: true,
          title: Text('Sowftware Engineer',
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
        ),
        body:Stack(
            children: [
              ListView.builder(itemCount: 1,itemBuilder: (context, index) {
                return Column(
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
                                  fit: BoxFit.fill),
                              shape: BoxShape.circle)),
                    ),
                    Center(child: Text('choose the Division',style: TextStyle(fontSize:35,),)),
                    Container(
                      height: 320,
                      width:250,
                      alignment: Alignment.center,
                      child:ListView.builder(itemCount: widget.list.length,itemBuilder: (context, index) {
                        return Padding(padding: const EdgeInsets.all(0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                div=widget.list[index].section;
                                print("div !!");
                                print(div);
                                print(widget.stage1);
                                flag=true;
                              });
                              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return Choose(id:widget.list[index].id,id_material: widget.id_material,stage2:widget.stage1,div1: div,)   ;

                              }));
                              setState(() {
                                flag=false;
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
                                  title: Center(child: Text(widget.list[index].section)),
                                ),

                              ),
                            ),
                          ),


                        );
                      },) ,
                    )
                  ],
                );
              },),
              Visibility(child: CircularProgressIndicator(
                strokeWidth: 2.9,

              ),visible: flag,)
            ]
        )

    );
  }
}
