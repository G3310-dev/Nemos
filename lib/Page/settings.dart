import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/action_bar.dart';
import 'package:nemos/Component/law_expert.dart';
import 'package:nemos/Component/orline.dart';
import 'package:provider/provider.dart';
import '../Component/button.dart';
import '../Component/drawer.dart';
import '../Component/text_model.dart';
import '../Wrapper/auth_wrapper.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('UserData').doc('${user?.email}').collection('Username');

    return Scaffold(
      drawer: const DrawerDef(),
      key: _scaffoldKey,
      body: Column(
        children: [
          const ActionBar(title: 'Profile',),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height*0.6,
                width: double.infinity,
                alignment: Alignment.center,
                child: StreamBuilder(
                    stream: collectionReference.snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data!.size == 1) {
                        return Center(
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: snapshot.data!.docs.map((e) => Center(
                              child: Column(
                                children: [
                                  SvgPicture.asset("asset/images/icon/logo.svg",
                                    colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn),
                                    width: 90,
                                  ),
                                  const TextWidget(size: 40.0, content: "What's up?", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                                  TextWidget(size: 19.0, content: "${e["Username"]}", type: 0, colour: 0xFF364D63, alignment: TextAlign.center),
                                  const SizedBox(height: 20,),
                                  Center(
                                      child: "${e['Certificate']}".isEmpty
                                          ? const SizedBox.shrink()
                                          : LawExpert(type: 1, width: MediaQuery.sizeOf(context).width * 0.3, height: MediaQuery.sizeOf(context).height * 0.03, size: 15.0)
                                  ),
                                  const SizedBox(height: 20,),
                                  TextWidget(size: 20.0, content: user?.email, type: 2, colour: 0xFF364D63, alignment: TextAlign.center),
                                  TextWidget(size: 15.0, content: user?.uid, type: 1, colour: 0xFF364D63, alignment: TextAlign.center),
                                  const SizedBox(height: 50,),
                                  Center(
                                    child: "${e['Certificate']}".isNotEmpty
                                        ? const SizedBox.shrink()
                                        : Column(
                                      children: [
                                        ButtonDef(
                                          width: MediaQuery.sizeOf(context).width * 0.5,
                                          height: MediaQuery.sizeOf(context).height * 0.04,
                                          type: 1,
                                          onTap: () {
                                            Navigator.pushNamed(context, "/addCerti");
                                          },
                                          text: "Verify Certificate",
                                          size: 15,
                                        ),
                                        SizedBox(
                                            width: MediaQuery.sizeOf(context).width*0.3,
                                            child: const OrLine()
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 3,),

                                  const SizedBox(height: 3,),
                                  Center(
                                    child: ButtonDef(
                                        width: MediaQuery.sizeOf(context).width*0.5,
                                        height: MediaQuery.sizeOf(context).height*0.04,
                                        type: 2,
                                        onTap: () async{
                                          try {
                                            await context.read<AuthWrap>().signOut();
                                            Navigator.pushReplacementNamed(context, "/getStart");
                                          } catch(e){
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(e.toString().trim()),
                                              duration: const Duration(milliseconds: 700),
                                            ));
                                          }
                                        },
                                        text: "Sign Out", size: 16),
                                  ),
                                ],
                              ),
                            )).toList(),
                          ),
                        );
                      }
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height*0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("asset/images/icon/logo.svg",
                              colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn),
                              width: 90,
                            ),
                            const TextWidget(size: 40.0, content: "What's up?", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                            const TextWidget(size: 19.0, content: "Unknown User", type: 0, colour: 0xFF364D63, alignment: TextAlign.center),
                            const SizedBox(height: 50,),
                            Center(
                              child: ButtonDef(
                                  width: MediaQuery.sizeOf(context).width*0.5,
                                  height: MediaQuery.sizeOf(context).height*0.04,
                                  type: 1,
                                  onTap: (){
                                    Navigator.pushNamed(context, "/addUser");
                                  },
                                  text: "Add Username", size: 15),
                            ),
                            const SizedBox(height: 3,),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width*0.3,
                                child: const OrLine()
                            ),
                            const SizedBox(height: 3,),
                            Center(
                              child: ButtonDef(
                                  width: MediaQuery.sizeOf(context).width*0.5,
                                  height: MediaQuery.sizeOf(context).height*0.04,
                                  type: 2,
                                  onTap: () async{
                                    try {
                                      await context.read<AuthWrap>().signOut();
                                      Navigator.pushReplacementNamed(context, "/getStart");
                                    } catch(e){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text(e.toString().trim()),
                                        duration: const Duration(milliseconds: 700),
                                      ));
                                    }
                                  },
                                  text: "Sign Out", size: 16),
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}