import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neo_todo/Pages/homePage.dart';
import 'package:neo_todo/Pages/signUpPage.dart';
import 'package:neo_todo/services/authservice.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignUpPage();
  MyAuth authclass = MyAuth();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checklogin();
  }
  void checklogin() async{
    String token =  await authclass.getToken() as String;
    if(token != null){
      setState(() {
        currentPage= HomePage();
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: currentPage,
    );
  }
}


