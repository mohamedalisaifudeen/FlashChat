import 'package:firebase_auth/firebase_auth.dart';
import "frm.dart";
import "package:flutter/material.dart";
import "chatScreen.dart";
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class loginScreen extends StatefulWidget {
  static const String login="LoginScreen";
  late String email;
  late String password;
  final _auth =FirebaseAuth.instance;


  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool saving=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: saving,
        child: Frm(labeltxt1: "Enter Username", labeltxt2: "Enter password", press: ()async{
          setState(() {
            saving=true;
          });
          try{

            UserCredential userCred=await widget._auth.signInWithEmailAndPassword(email: widget.email, password: widget.password);
            if(userCred!=null){

              Navigator.pushNamed(context,"/${chatScreen.chat}");
            }
            print(saving);

          }on FirebaseAuthException catch (e){
            if(e.code=="user-not-found"){
              print("No user found");
            }else if(e.code=='wrong-password'){
              print('Wrong password');
            }
          }

          setState(() {
            saving=false;
          });

        }, btnTxt: "Login",value: (val){
          widget.email=val;
        },value2: (value){
          widget.password=value;
        },),
      ),
    );
  }
}






