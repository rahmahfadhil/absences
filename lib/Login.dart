import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appfirstabceness/themeterial.dart';

import 'package:http/http.dart' as ht;
import 'meterial.dart';




class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool rah=false;
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  String str1="Email" ;
  String str2="password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/flutter.jpg'), fit: BoxFit.fill)),
          ),

          ListView(
            children: [
              Container(
                height:300,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(


                  ),
                ),
              ),
              Container(
                height: 100,
                //color: Colors.blue,



                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        children: [

                          Text(
                            'Sign in',
                            style: TextStyle(color: Colors.indigo[700], fontSize:40),
                          ),
                          Text(
                            'enter your email please',
                            style: TextStyle(color: Colors.indigo[700], fontSize: 20),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height/2,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.grey[300],
                        child: Container(
                          width: MediaQuery.of(context).size.width,

                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: StatefulBuilder(
                              builder: (context, setstate) {
                                return TextField(
                                  controller: emailControl,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText:"Email",
                                    hintStyle: TextStyle(
                                      color: Colors.black38,
                                    ),
                                    icon: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius: 20.0,
                                      child: Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        color: Colors.grey[300],
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: StatefulBuilder(
                                builder: (context, setstate) {
                                  return TextField(
                                    controller: passwordControl,
                                    style: TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                        color: Colors.black38,
                                      ),
                                      icon: CircleAvatar(
                                        backgroundColor: Colors.grey[300],
                                        child: Icon(
                                          Icons.vpn_key_rounded,
                                          color: Colors.black,

                                        ),
                                      ),
                                    ),
                                    obscureText: true,
                                  );
                                },
                              )),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [

                              GestureDetector(
                                onTap: () async {

                                  setState(() {

                                    str1 = emailControl.text;
                                    str2 = passwordControl.text;
                                    rah=true;
                                  });
                                  String url = 'https://vardevs.com/college/login.php';
                                  Map map = {
                                    "email": "${str1}",
                                    "password": "${str2}",
                                  };
                                  ht.Response response = await ht.post(url, body: map);
                                  String str = utf8.decode(response.bodyBytes);
                                  List list = jsonDecode(str);

                                  if (response.body.trim() != "0") {
                                    print('response status:${response.statusCode}');
                                    print('response status:${response.body}');
                                    print(list);
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(builder: (context) {
                                      return TheMeterial(lists: initTables(list));
                                    }));
                                    setState(() {
                                      rah=false;
                                    });
                                  }





                                },
                                child: Material(
                                  borderRadius: BorderRadius.circular(30),
                                  shadowColor: Colors.indigo[700],
                                  color: Colors.indigo[500],
                                  child: Container(

                                    height: 60,
                                    width: 300,
                                    child: Center(
                                      child: Text(
                                        'Sign in',
                                        style: TextStyle(color: Colors.white, fontSize: 30),
                                      ),
                                    ),
                                  ),
                                ),
                              ),


                              Container(
                                child: Text(
                                  'forget your password?',
                                  style: TextStyle(color: Colors.red, fontSize: 15),
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(child:
                        CircularProgressIndicator(
                          strokeWidth: 2.9,
                        ),
                          visible: rah,)
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}




initTables(List json) {
  List<meterial> list = List();
  json.forEach((element) {
    list.add(meterial(element));
  });
  return list;
}
