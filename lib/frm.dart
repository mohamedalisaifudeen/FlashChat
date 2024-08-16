import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';

class Frm extends StatelessWidget {
  late String labeltxt1;
  late String labeltxt2;
  late VoidCallback press;
  late String btnTxt;
  final ValueChanged<String>?  value;
  final ValueChanged<String>? value2;

  Frm({required String this.labeltxt1,required String this.labeltxt2,required VoidCallback this.press,required String this.btnTxt, required ValueChanged<String>?  this.value,required ValueChanged<String>?  this.value2});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Hero(
              tag: "iocn=tag",
              child: Icon(
                Icons.electric_bolt,
                size: 150,
                color: Colors.amber,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          SizedBox(
            width: 300,
            child: TextField(
              keyboardType:TextInputType.emailAddress,
              onChanged:value,
              decoration: InputDecoration(
                  labelText: labeltxt1,
                  border: OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.blueAccent,width: 10.0),
                    borderRadius: BorderRadius.circular(10.0),
                    gapPadding: 4.0,

                  )
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),

          SizedBox(
            width: 300,
            child: TextField(
              obscureText: true,
              onChanged: value2,
              decoration: InputDecoration(
                  labelText: labeltxt2,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.black,width: 2)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,width: 2)
                  )
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 30),
            width: 300,
            decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(12)
            ),
            child: TextButton(
              onPressed: press,
              child: Text(
                  btnTxt,
                style: TextStyle(
                  color:Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
