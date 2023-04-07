import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neo_todo/services/authservice.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override

  int start =0;
  bool wait = false;
  String nameb="send";

  TextEditingController phoneNumberController = TextEditingController();
  String verficationIdfinal ="";
  String smsCode = "";
  MyAuth auth = MyAuth();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Signup",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ),
              formField(),
              SizedBox(
                height: 40,
              ),
              Container(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                      const Text(
                        "Enter 6 digit OTP",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 40,
              ),
              pinfield(),
              SizedBox(
                height: 40,
              ),
              
              RichText(text: TextSpan(
                children: [
                  const TextSpan(
                   text: "Resend OTP in",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.yellowAccent
                    )),
                  TextSpan(
                   text: "00:$start",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.yellowAccent)

                  ),
                  const TextSpan(
                      text: " sec ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.pink
                      )),
                ]
              )),

              SizedBox(
                height: 40,
              ),
              SubmitButton()

            ],
          ),
        ),
      ),
    );
  }


  Widget SubmitButton(){
    return InkWell(
      onTap: (){
        auth.signInnumber(verficationIdfinal, smsCode, context);
      },

      child: Container(
        width: MediaQuery.of(context).size.width -150,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(colors: [
            Color(0xfffd746c),
            Color(0xffff9068),
            Color(0xfffd746c)
          ]),
        ),
        child: const Center(
          child: Text(
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
  void otptimer(){
    const onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec,(timer){
      if(start == 0){
        setState(() {
          timer.cancel();
          wait = false;
        });
      }
      else{
        setState(() {
          start--;
        });
      }

    });
  }
  Widget pinfield() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 50,
      style: TextStyle(fontSize: 17, color: Colors.white),
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);

       setState(() {
         smsCode=pin;
       });
      },
    );
  }

  Widget formField() {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xff1d1d1d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: phoneNumberController,
        style:  const TextStyle(
          color: Colors.white,
          fontSize: 16),
        decoration:  InputDecoration(

            hintText: 'Enter your phone Number',
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 4),

            hintStyle: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
              child: Text(
                " (+91) ",
                style: TextStyle(
                   color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
            suffixIcon: InkWell(
              onTap: wait ?null :() async{

                setState(() {
                  start = 30;
                  wait = true;
                  nameb="resend";
                });

                await auth.verifynumber("+91 ${phoneNumberController.text}", context,setData);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                child: Text(
               nameb,
                style: TextStyle(
                    color:wait? Colors.grey: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
                  ),
              ),
            )
        )
      ),
    );



  }
  void setData(verficationId){
    setState(() {
      verficationIdfinal=verficationId;
    });
    otptimer();

  }

}
