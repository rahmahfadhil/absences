import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Absence extends StatefulWidget {
  @override
  _StudState createState() => _StudState();
}

class _StudState extends State<Absence> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: Text("Software Engineering"),
      ),
      body: ListView.builder(
        itemCount:5,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(

              child: Card(
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  elevation: 5,
                  child:ListTile(
                    title: Center(child: Text("نور سمير ",style: TextStyle(color: Colors.black, fontSize: 20),)),
                    trailing:Column(
                      children: [
                        Text(":ايام الغياب ",style: TextStyle(color: Colors.black, fontSize: 10),),
                        Text("1 ",style: TextStyle(color: Colors.black, fontSize: 20),),
                      ],
                    ),

                  )
              ),
            ),
          );

        },
      ),
    );
  }
}
