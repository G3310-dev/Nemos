import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/button.dart';
import 'package:nemos/Component/text_model.dart';
import 'package:nemos/Component/text_field.dart';

import '../Wrapper/database_wrapper.dart';

class Testing extends StatefulWidget {
  final String docId;
  const Testing({Key? key,
    required this.docId
  }) : super(key: key);

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');
    final dbControl = DbWrapper();
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 17, left: 12),
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
                const TextWidget(size: 40.0, content: "Hi Devs!", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                const TextWidget(size: 19.0, content: "Test your data here", type: 0, colour: 0xFF364D63, alignment: TextAlign.center),
                const SizedBox(height: 30,),
                FieldText(text: "Input 1", height: 50, desc: 'Comment', obs: false, control: emailController, textType: 2,),
                const SizedBox(height: 10,),
                ButtonDef(
                  width: MediaQuery.sizeOf(context).width*0.85,
                  height: MediaQuery.sizeOf(context).height*0.05,
                  type: 1,
                  onTap: () {
                    dbControl.addComment("${user?.email}", emailController.text, widget.docId, "${user?.email}", Timestamp.now());
                  },
                  text: "Send",
                  size: 18,
                ),
                const SizedBox(height: 10,),
                ButtonDef(
                  width: MediaQuery.sizeOf(context).width*0.85,
                  height: MediaQuery.sizeOf(context).height*0.05,
                  type: 1,
                  onTap: () {
                    dbControl.read();
                  },
                  text: "Read",
                  size: 18,
                ),
                const SizedBox(height: 10,),
                ButtonDef(
                  width: MediaQuery.sizeOf(context).width*0.85,
                  height: MediaQuery.sizeOf(context).height*0.05,
                  type: 1,
                  onTap: () {
                    // dbControl.delete("${e['Id']}", );
                  },
                  text: "Delete",
                  size: 18,
                ),
                const SizedBox(height: 7,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
