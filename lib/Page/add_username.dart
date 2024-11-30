import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/button.dart';
import 'package:nemos/Component/text_model.dart';
import 'package:nemos/Component/text_field.dart';

import '../Wrapper/database_wrapper.dart';

class AddUsername extends StatefulWidget {
  const AddUsername({Key? key}) : super(key: key);

  @override
  State<AddUsername> createState() => _AddUsernameState();
}

class _AddUsernameState extends State<AddUsername> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final dbControl = DbWrapper();
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 25, left: 12),
            width: 50,
            height: 50,

            child: SvgPicture.asset("asset/images/icon/logo.svg",
                colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn)
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const TextWidget(size: 40.0, content: "Hi There!", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                const TextWidget(size: 19.0, content: "What's your name?", type: 0, colour: 0xFF364D63, alignment: TextAlign.center),
                const SizedBox(height: 30,),

                const SizedBox(height: 30,),
                FieldText(text: "Enter your name here!", height: 50, desc: 'Enter your name here!, you cannot change it in the future', obs: false, control: usernameController, textType: 2,),
                const SizedBox(height: 15,),
                ButtonDef(
                  width: MediaQuery.sizeOf(context).width*0.85,
                  height: MediaQuery.sizeOf(context).height*0.05,
                  type: 1,
                  onTap: () async {
                    if(usernameController.text.isNotEmpty){
                      await dbControl.addUser(usernameController.text, "${user?.email}", "");

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Wait..."),
                        duration: Duration(milliseconds: 700),
                      ));
                      Navigator.pushReplacementNamed(context, "/");
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please Enter Your Username"),
                        duration: Duration(milliseconds: 700),
                      ));
                    }
                  },
                  text: "Add Username",
                  size: 18,
                ),
                const SizedBox(height: 7,),
                const TextWidget(size: 13.0, content: "*You can only change it here or in certificate confirmation", type: 3, colour: 0xFF364D63, alignment: TextAlign.center),
              ],
            ),
          )
        ],
      ),
    );
  }
}
