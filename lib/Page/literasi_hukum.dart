import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Component/action_bar.dart';
import '../Component/drawer.dart';
import '../Component/forum_button.dart';
import '../Component/text_model.dart';

class LiteraKum extends StatefulWidget {
  const LiteraKum({super.key});

  @override
  State<LiteraKum> createState() => _LiteraKumState();
}

class _LiteraKumState extends State<LiteraKum> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('LiteraKum');

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerDef(),
      key: _scaffoldKey,
      body: Stack(
        children: [
          // GestureDetector(
          //   onTap: (){
          //     if(user?.email == "sainsglenn@gmail.com"){
          //       Navigator.pushNamed(context, "/literaKum");
          //     }
          //   },
          //     child: const ActionBar(title: 'Nemos LiteraKum')
          // ),
          const ActionBar(title: 'Nemos LiteraKum'),
          Container(
            margin: const EdgeInsets.only(top: 95),
            child: SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width*0.94,
                  child: StreamBuilder(
                    stream: collectionReference.orderBy("PostDate", descending: true).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.data!.size >= 1) {
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          reverse: false,
                          children: snapshot.data!.docs.map((e) {
                            return Center(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x40000000),
                                        blurRadius: 7.0,
                                        spreadRadius: 0.0,
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(27),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(left: 18, top: 20),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.light_rounded,
                                                color: Color(0xFFFFC300),
                                                size: 35,
                                              ),
                                              const SizedBox(width: 10,),
                                              SizedBox(
                                                width: MediaQuery.of(context).size.width*0.7,
                                                child: const Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(size: 20.0, content: "Nemos Knowledge", type: 2, colour: 0xFF304457, alignment: TextAlign.left),
                                                  ],
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextWidget(size: 19.0, content: "${e['Title']}", type: 2, colour: 0xFF445B72, alignment: TextAlign.start),
                                              const SizedBox(height: 5,),
                                              ReadMoreText(
                                                "${e['Description']}",
                                                style: const TextStyle(color: Color(0xFF525252)),
                                                trimMode: TrimMode.Line,
                                                trimLines: 3,
                                                colorClickableText: const Color(0xFF525252),
                                                trimCollapsedText: 'Show more',
                                                trimExpandedText: '...Show less',
                                                moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                              ),
                                              Center(
                                                child: e['Image'] != null && e['Image'].isNotEmpty
                                                    ? Container(
                                                  margin: const EdgeInsets.only(top: 10),
                                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                                  height: MediaQuery.sizeOf(context).height * 0.22,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(Uri.parse("${e['Image']}").toString()),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ):const SizedBox.shrink(),
                                              ),

                                              const SizedBox(height: 13,),
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          launchUrl(Uri.parse("${e['Resource']}"));
                                                        },
                                                        child: const ForumButton(image: "asset/images/icon/res.svg", desc: "Read More",)
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.dark_mode,
                              color: Color(0xFF525252),
                              size: 50,
                            ),
                            TextWidget(
                              size: 20.0,
                              content: "No Data Available!",
                              type: 2,
                              colour: 0xFF525252,
                              alignment: TextAlign.center,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
