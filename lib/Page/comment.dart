import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Component/text_field.dart';
import '../Component/text_model.dart';
import '../Wrapper/database_wrapper.dart';

class Comment extends StatefulWidget {
  final String docId;
  const Comment({super.key,
    required this.docId
  });

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('BukaMataForum').doc(widget.docId).collection("Comment");
    final dbControl = DbWrapper();
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 23, left: 15, right: 30, bottom: 20),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("asset/images/icon/logo.svg",
                        colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn),
                        width: 40,
                        height: 40,
                      ),
                      const Spacer(),
                      const TextWidget(size: 25.0, content: "Case Comment", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width*0.9,
                  child: StreamBuilder(stream: collectionReference.orderBy("PostDate", descending: true).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.data!.size >= 1){
                        return ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          reverse: false,
                          children: snapshot.data!.docs.map((e) => Container(
                            margin: const EdgeInsets.only(top: 10,),
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(color: Color(0x40000000),
                                      blurRadius: 7.0,
                                      spreadRadius: 0.0,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(27),
                                  color: Colors.white
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 18, top: 20),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset("asset/images/icon/userpic.svg",
                                            width: 35,
                                            height: 35,
                                            colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn),
                                          ),
                                          const SizedBox(width: 10,),
                                          TextWidget(size: 18.0, content: "${e['Username']}", type: 2, colour: 0xFF304457, alignment: TextAlign.start),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(left: 20, top: 5, bottom: 10),
                                        child: TextWidget(size: 18.0, content: "${e['Comment']}", type: 1, colour: 0xFF525252, alignment: TextAlign.start)
                                    ),
                                    const SizedBox(height: 5,)
                                  ],
                                ),
                              ),
                            ),



                          )).toList(),
                        );
                      }else{
                        return const Column(
                          children: [
                            SizedBox(height: 100,),
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF304457)),
                            ),
                            SizedBox(height: 10,),
                            Center(
                                child: TextWidget(size: 20.0, content: "No Data Available!", type: 2, colour: 0xFF304457, alignment: TextAlign.center)
                            ),
                          ],
                        );
                      }
                    },

                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        height: 50,
                        padding: const EdgeInsets.only(left: 20, right: 14),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2,
                                color: const Color(0XFFBCBCBC)
                            ),
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), bottomLeft: Radius.circular(100))
                        ),
                        child: TextFormField(
                          controller: commentController,
                          maxLines: null,
                          decoration: const InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              border: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "Add Comment",
                              hintStyle: TextStyle(
                                  color: Color(0XFF7A7A7A),
                                  fontWeight: FontWeight.w500
                              )
                          ),
                        )
                    ),
                    Container(
                      width: 55,
                      height: 50,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(100)),
                          color: Color(0xFF304457)
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if(commentController.text.isNotEmpty){
                            dbControl.addComment("${user?.email}", commentController.text, widget.docId, "${user?.email}", Timestamp.now());
                            commentController.clear();
                          }
                        },
                        child: const Icon(Icons.send_rounded,
                          size: 27,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
