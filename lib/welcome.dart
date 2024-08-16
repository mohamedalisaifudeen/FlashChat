import "package:flash_chat/registrationScreen.dart";
import "package:flutter/cupertino.dart";
import "loginScreen.dart";
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomePage extends StatefulWidget {

  static const String id="WelcomeScreen";



  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;



  @override
  void initState() {

  // TODO: implement initState
  super.initState();

  controller=AnimationController(
  duration: const Duration(seconds: 1),
  vsync:this,
  );

  animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
  controller.forward();
  controller.addListener((){
    setState(() {});

  });

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [
                SizedBox(width: 20,),
                Hero(
                  tag: "iocn=tag",
                  child: Icon(
                    Icons.electric_bolt,
                    size: animation.value*100,
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText("Flash Chat",textStyle: TextStyle(
                        fontSize: 50,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      )),


                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(

            margin: EdgeInsets.only(left: 30,right: 30,top: 30),
            height: 53,
            width: MediaQuery.sizeOf(context).width,
            child: TextButton(onPressed: (){
              Navigator.pushNamed(context, "/${loginScreen.login}");
            },
              child: Text("Login",
                  style: TextStyle(fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  )
              ),
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
              ),

            ),
          ),
          SizedBox(height: 20,),

          Container(
            margin: EdgeInsets.only(left: 30,right: 30),
            height: 53,
            width: MediaQuery.sizeOf(context).width,
            child: TextButton(onPressed: (){
              Navigator.pushNamed(context, "/${registraionScreen.register}");
            },
                style: ButtonStyle(

                  backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text("Register", style: TextStyle(fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ))),
          )
        ],
      ),
    );
  }
}

