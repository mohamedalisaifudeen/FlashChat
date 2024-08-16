import "chatScreen.dart";
import "package:flutter/material.dart";
import "frm.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';



class registraionScreen extends StatefulWidget {
  static const String register="Register";
  final _auth =FirebaseAuth.instance;
  late String email;
  late String password;
  bool _saving=false;

  @override
  State<registraionScreen> createState() => _registraionScreenState();
}

class _registraionScreenState extends State<registraionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
          child: Frm(labeltxt1: "Enter email", labeltxt2:"Set password", press:()async{
            setState(() {
              widget._saving=true;
            });
            try{
              final newUser=await widget._auth.createUserWithEmailAndPassword(email: widget.email, password: widget.password);
              if(newUser!=null){
                Navigator.pushNamed(context,"/${chatScreen.chat}");
              }
            }on FirebaseAuthException catch (e){
              if(e.code=='weak-password'){
                print("The password is weak");
              }else if(e.code=="email-already-in-use"){
                print("Account in use");
              }
            }catch (e){
              print(e);
            }

            setState(() {
              widget._saving=false;
            });

            print(widget.email);
            print(widget.password);

          }, btnTxt: "Register",value: (val){
            widget.email=val;
          },value2: (value){
            widget.password=value;
          },),
          inAsyncCall: widget._saving
      ),
    );
  }
}

