import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/forum_button.dart';
import 'package:nemos/Component/text_model.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Page/comment.dart';
import '../Wrapper/database_wrapper.dart';
import 'law_expert.dart';

class Forum extends StatelessWidget {
  const Forum({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('BukaMataForum');
    User? user = FirebaseAuth.instance.currentUser;
    final dbControl = DbWrapper();

    return StreamBuilder(
      stream: collectionReference.orderBy("PostDate", descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data!.size >= 1) {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            reverse: false,
            children: snapshot.data!.docs.map((e) {
              final CollectionReference collectionReference2 = FirebaseFirestore.instance.collection('UserData').doc('${e['Username']}').collection('Username');

              return Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                padding: const EdgeInsets.only(top: 5, bottom: 10),
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
                              SvgPicture.asset(
                                "asset/images/icon/userpic.svg",
                                width: 35,
                                height: 35,
                                colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn),
                              ),
                              const SizedBox(width: 10,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.7,
                                child: StreamBuilder(
                                    stream: collectionReference2.snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.data!.size >= 1) {
                                        return Center(
                                          child: ListView(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            children: snapshot.data!.docs.map((f) => Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    TextWidget(size: 20.0, content: "${f['Username']}", type: 2, colour: 0xFF304457, alignment: TextAlign.left),
                                                    "${f['Certificate']}".isEmpty
                                                        ? const SizedBox.shrink()
                                                        : LawExpert(type: 1, width: MediaQuery.sizeOf(context).width * 0.28, height: MediaQuery.sizeOf(context).height * 0.025, size: 15.0),
                                                  ],
                                                ),
                                                const Spacer(),
                                                GestureDetector(
                                                  onTap: (){
                                                    if("${e['Username']}" == user?.email){
                                                      Widget cancelButton = TextButton(
                                                        child: const TextWidget(size: 15.0, content: "No", type: 2, colour: 0xFF304457, alignment: TextAlign.start),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      );
                                                      Widget launchButton = TextButton(
                                                        child: const TextWidget(size: 15.0, content: "Yes", type: 2, colour: 0xFF304457, alignment: TextAlign.start),
                                                        onPressed: () async {
                                                          await dbControl.deleteForum("${e['Id']}", );
                                                          Navigator.of(context).pop();
                                                        },
                                                      );
                                                      AlertDialog alert = AlertDialog(
                                                        backgroundColor: Colors.white,
                                                        title: const TextWidget(size: 25.0, content: "WARNING!", type: 1, colour: 0xFFFF0004, alignment: TextAlign.start),
                                                        content: const TextWidget(size: 15.0, content: "Do you really wanna delete this forum?", type: 2, colour: 0xFFFF0004, alignment: TextAlign.start),
                                                        actions: [
                                                          cancelButton,
                                                          launchButton,
                                                        ],
                                                      );

                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return alert;
                                                        },
                                                      );
                                                    } else{
                                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                        content: Text("You can't delete this user post"),
                                                        duration: Duration(milliseconds: 1000),
                                                      ));
                                                    }
                                                  },
                                                  child: const Icon(Icons.more_vert_rounded,
                                                    color: Color(0xFF304457),
                                                  ),
                                                )
                                              ],
                                            )).toList(),
                                          ),
                                        );
                                      }
                                      return SizedBox(
                                        height: MediaQuery.sizeOf(context).height*0.04,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TextWidget(size: 20.0, content: "Unknown User ", type: 2, colour: 0xFF304457, alignment: TextAlign.left),
                                              ],
                                            ),
                                            const Spacer(),
                                            Container(
                                              margin: const EdgeInsets.only(top: 5),
                                              child: GestureDetector(
                                                onTap: (){
                                                  Widget cancelButton = TextButton(
                                                    child: const TextWidget(size: 15.0, content: "No", type: 2, colour: 0xFF304457, alignment: TextAlign.start),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  );
                                                  Widget launchButton = TextButton(
                                                    child: const TextWidget(size: 15.0, content: "Yes", type: 2, colour: 0xFF304457, alignment: TextAlign.start),
                                                    onPressed: () async {
                                                      await dbControl.deleteForum("${e['Id']}", );
                                                      Navigator.of(context).pop();
                                                    },
                                                  );
                                                  AlertDialog alert = AlertDialog(
                                                    backgroundColor: Colors.white,
                                                    title: const TextWidget(size: 25.0, content: "WARNING!", type: 1, colour: 0xFFFF0004, alignment: TextAlign.start),
                                                    content: const TextWidget(size: 15.0, content: "Do you really wanna delete this forum?", type: 2, colour: 0xFFFF0004, alignment: TextAlign.start),
                                                    actions: [
                                                      cancelButton,
                                                      launchButton,
                                                    ],
                                                  );

                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return alert;
                                                    },
                                                  );
                                                },
                                                child: const Icon(Icons.more_vert_rounded,
                                                  color: Color(0xFF304457),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      );
                                    }
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
                                        child: const ForumButton(image: "asset/images/icon/res.svg", desc: "Resource",)
                                    ),
                                    const SizedBox(width: 5,),
                                    GestureDetector(
                                      onTap: () async {
                                        String? userId = user?.uid;
                                        DocumentReference upvoteRef = FirebaseFirestore.instance
                                            .collection('BukaMataForum')
                                            .doc("${e['Id']}")
                                            .collection('Upvotes')
                                            .doc(userId);

                                        DocumentSnapshot upvoteSnapshot = await upvoteRef.get();
                                        if (upvoteSnapshot.exists) {
                                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                            content: Text("You've upvoted it"),
                                            duration: Duration(milliseconds: 500),
                                          ));
                                        }else {
                                          await upvoteRef.set({'upvoted': true});
                                          await collectionReference.doc("${e['Id']}").update({
                                            'upvoteCount': FieldValue.increment(1),
                                          });
                                        }
                                      },
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection('BukaMataForum')
                                            .doc("${e['Id']}")
                                            .collection('Upvotes')
                                            .snapshots(),
                                        builder: (context, AsyncSnapshot<QuerySnapshot> upvoteSnapshot) {
                                          int upvoteCount = upvoteSnapshot.data?.docs.length ?? 0;
                                          return ForumButton(image: "asset/images/icon/upvote.svg", desc: "$upvoteCount");
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Comment(
                                              docId: '${e['Id']}'
                                          )));
                                        },
                                        child: const ForumButton(image: "asset/images/icon/comment.svg", desc: "Comment",)
                                    )
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
              );
            }).toList(),
          );
        } else {
          return const SizedBox(
            height: 200,
            child: Column(
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
            ),
          );
        }
      },
    );
  }
}