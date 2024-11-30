import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/button.dart';
import 'package:nemos/Component/text_model.dart';
import 'package:nemos/Component/text_field.dart';

import '../Wrapper/database_wrapper.dart';

class AddCertificate extends StatefulWidget {
  const AddCertificate({Key? key}) : super(key: key);

  @override
  State<AddCertificate> createState() => _AddCertificateState();
}

class _AddCertificateState extends State<AddCertificate> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController certificateController = TextEditingController();

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
                const TextWidget(size: 40.0, content: "Hi Sir!", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                const TextWidget(size: 19.0, content: "Please enter your law certification", type: 0, colour: 0xFF364D63, alignment: TextAlign.center),
                const SizedBox(height: 30,),

                const SizedBox(height: 30,),
                FieldText(text: "Enter your username here!", height: 50, desc: 'Enter your certificate here!', obs: false, control: usernameController, textType: 2,),
                const SizedBox(height: 15,),
                FieldText(text: "Enter your certificate here!", height: 50, desc: 'Enter your certificate here!', obs: false, control: certificateController, textType: 2,),
                const SizedBox(height: 15,),
                ButtonDef(
                  width: MediaQuery.sizeOf(context).width*0.85,
                  height: MediaQuery.sizeOf(context).height*0.05,
                  type: 1,
                  onTap: () async {
                    if(certificateController.text.isNotEmpty){
                      if(Uri.parse(certificateController.text).isAbsolute){
                        await dbControl.addUser(usernameController.text, "${user?.email}", certificateController.text);
                      }

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
                const TextWidget(size: 13.0, content: "*You can't change your certificate again in future", type: 3, colour: 0xFF364D63, alignment: TextAlign.center),
              ],
            ),
          )
        ],
      ),
    );
  }
}
