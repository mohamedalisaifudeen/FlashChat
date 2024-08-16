import "package:flash_chat/registrationScreen.dart";
import "package:flutter/material.dart";
import "welcome.dart";
import "loginScreen.dart";
import "chatScreen.dart";
import "package:firebase_core/firebase_core.dart";


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyBuf9Yw-CbqsTlLfK7XwRP_-ZCyNICf41w',
        appId: '1:1034929446919:android:f93d115e538d0e71cd4aa2',
        messagingSenderId: '1034929446919',
        projectId: 'flashchat-7b9a9',
       )
  );
  runApp(HomePage());
}

class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
      initialRoute: "/${WelcomePage.id}",
      routes: {
        "/${WelcomePage.id}":(context)=>WelcomePage(),
        "/${chatScreen.chat}":(context)=>chatScreen(),
        "/${loginScreen.login}":(context)=>loginScreen(),
        "/${registraionScreen.register}":(context)=>registraionScreen(),

      },
    );
  }
}
