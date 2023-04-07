import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth ;
import 'package:neo_todo/Pages/homePage.dart';
import 'package:neo_todo/Pages/phoneAuthPage.dart';
import 'package:neo_todo/Pages/signInPage.dart';
import 'package:neo_todo/services/authservice.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth= firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool circluar = false;
  MyAuth authclass = MyAuth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ButtonC("Continue with Google", "assets/google.svg", 25,()async{

                await authclass.googleSignIn(context);
              }),
              const SizedBox(
                height: 15,
              ),
              ButtonC("Continue with phone", "assets/phone.svg", 25,(){

                Navigator.push(context,MaterialPageRoute(builder:(builder) =>const OtpScreen()));
              }),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Or",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormC("Email",_emailController,false),
              const SizedBox(
                height: 15,
              ),
              TextFormC("Password",_passController,true),
              const SizedBox(
                height: 25,
              ),
              SubmitButton(),
              const SizedBox(
                height: 25,
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const Text(
                "If you alredy have an Account? ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
           InkWell(
             onTap: (){
Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder)=>const SignInPage()), (route) => false);
             },
             child: const Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
          ),
           ),
            ]
        )

            ],
          ),
        ),
      ),
    );
  }

Widget SubmitButton(){
  return InkWell(
    onTap: () async{
      setState(() {
        circluar= true;
      });
      try{
      firebase_auth.UserCredential userCredential  =
      await firebaseAuth.createUserWithEmailAndPassword(email: _emailController.text, password: _passController.text);
      //print(userCredential.user?.email);
      setState(() {
        circluar=false;
      });
      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (builder)=>const HomePage()), (route) => false);
      }
          catch (e){
        final snackBar = SnackBar(content:Text(e.toString()) );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

    },
    child: Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(colors: [
          Color(0xfffd746c),
          Color(0xffff9068),
          Color(0xfffd746c)
        ]),
      ),
      child: Center(
        child: circluar? const CircularProgressIndicator():const Text(
          "Sign Up",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),

    ),
  );
}

  Widget ButtonC(String text, String image, double size,VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: size,
              width: size,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget TextFormC(String text,TextEditingController _controller,bool ok) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        obscureText: ok,
        controller: _controller,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 14),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
          labelText: text,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
