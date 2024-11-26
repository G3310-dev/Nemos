import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/button.dart';
import 'package:nemos/Component/text_model.dart';
import 'package:nemos/Component/text_field.dart';

import '../Wrapper/database_wrapper.dart';

class Testing extends StatefulWidget {
  const Testing({Key? key}) : super(key: key);

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
                FieldText(text: "Input 1", height: 50, desc: 'Email', obs: false, control: emailController, textType: 2,),
                const SizedBox(height: 10,),
                FieldText(text: "Input 2", height: 50, desc: 'Password', obs: false, control: passwordController, textType: 2,),
                const SizedBox(height: 50,),
                ButtonDef(
                  width: MediaQuery.sizeOf(context).width*0.85,
                  height: MediaQuery.sizeOf(context).height*0.05,
                  type: 1,
                  onTap: () {
                    dbControl.create(emailController.text.trim(), passwordController.text.trim());
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
                    dbControl.delete();
                  },
                  text: "Delete",
                  size: 18,
                ),
                Expanded(
                    child: StreamBuilder(stream: collectionReference.snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return ListView(
                          reverse: false,
                          children: snapshot.data!.docs.map((e) => Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                            padding: const EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title:
                                  Column(
                                    children: [
                                      const SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Text('Amount: ${e['Name']}',textAlign: TextAlign.left, style: const TextStyle(color: const Color(
                                              0xff46795e), fontSize: 20, fontWeight: FontWeight.bold),),
                                          Text('   ${e['Age']}',textAlign: TextAlign.left, style: const TextStyle(color: Color(
                                              0xff46795e), fontSize: 18, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        );
                      },

                    )),
                const SizedBox(height: 7,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
