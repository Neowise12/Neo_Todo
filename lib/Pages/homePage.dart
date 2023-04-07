import 'package:flutter/material.dart';
import 'package:neo_todo/Pages/signInPage.dart';

import '../services/authservice.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyAuth authclass = MyAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: ()async{
            await authclass.logout();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>SignInPage()), (route) => false);
          },
              icon: Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
