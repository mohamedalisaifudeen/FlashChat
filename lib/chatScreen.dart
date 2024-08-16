

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class chatScreen extends StatefulWidget {
  static const String chat="Chatpage";


  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  final _auth=FirebaseAuth.instance;
  final _cloud=FirebaseFirestore.instance;
  late String message="None";
  late bool isMe;

  TextEditingController cntr=TextEditingController();

  var loggedInUser;
  void currentUser()async{
    final user=await _auth.currentUser;
    if(user!=null){
      loggedInUser=user;

    }



  }


  @override
  Widget build(BuildContext context) {
    currentUser();




    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          size: 35,
          weight: 25,
          color: Colors.white
        ),
        backgroundColor: Colors.lightBlueAccent,
        title: SafeArea(
          child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: 30),
                child: Text(
                  "Chat",
                  style: TextStyle(
          
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
          
                  ),
                ),
              )
          ),
        ),


      ),
      body: 
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget> [
               StreamBuilder<QuerySnapshot>(
                  stream:_cloud.collection("message").orderBy('timestamp', descending: false).snapshots() ,
                  builder: (context, snapshot){
                    if(snapshot.hasData){

                      List<Txtbubble> txt=[];
                      for( var i in snapshot.data!.docs.reversed){
                        print(i.data());
                        if(loggedInUser.email==i['sender']){
                          isMe=true;
                        }else{
                          isMe=false;
                        }
                        txt.add(
                            Txtbubble(text: "${i['text']}",sender:"${i['sender']}" ,color: isMe?Colors.lightBlue:Colors.redAccent,crs: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,)
                        );
                      }
                      return Expanded(
                        child: ListView(

                          reverse: true,
                          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical:20.0),
                          children: txt,
                        ),
                      );
                    }

                    return Text("");
                  },
                ),

              Row(
                children: [

                  Expanded(
                    child: Container(
                      padding:EdgeInsets.only(left: 20) ,

                      child: TextField(
                        controller:cntr ,
                        onChanged: (val){
                          message=val;
                        },
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          hintText: "Type your message here....",

                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      cntr.clear();


                    _cloud.collection("message").add(
                        {
                          "sender":loggedInUser.email,
                          "text":message,
                          "timestamp": FieldValue.serverTimestamp()
                        }
                    );
                    },
                    child: Text(
                        "Send",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.lightBlue
                      ),
                    ),
                  )
                ],
              ),
            ],
          )



    );
  }
}

class Txtbubble extends StatelessWidget {
  late String text;
  late String sender;
  late Color color;
  CrossAxisAlignment crs;





  Txtbubble({required String this.text,required String this.sender,required Color this.color,required CrossAxisAlignment this.crs});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:crs,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 10,left: 10,top: 10),
          child: Text(sender,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.black54,
          ),),
        ),
      Material(

      shadowColor: Colors.black54,
      child: Container(

          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(

              color:color ,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0))
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,

            ),

          )
      ),

    )
      ],
    );

  }
}

