import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth ;
import 'package:neo_todo/Pages/homePage.dart';

import '../services/authservice.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth= firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool circular = false;
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
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ButtonC("Continue with Google", "assets/google.svg", 25,(){
                authclass.googleSignIn(context);
              }),
              const SizedBox(
                height: 15,
              ),
              ButtonC("Continue with phone", "assets/phone.svg", 25,(){}),
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
                  children: const [
                    Text(
                      "If you don't have an Acoount?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      " SignUp",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),]
              ),

              Text(
                "Forget Password",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget SubmitButton(){
    return InkWell(
      onTap: () async{
        try{
          firebase_auth.UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: _emailController.text, password: _passController.text);
          print(userCredential.user?.email);
          setState(() {
            circular= false;
          });
          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (builder)=>HomePage()), (route) => false);

        }
            catch(e){

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
          child:circular? const CircularProgressIndicator():const Text(
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
      onTap: onTap ,
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
