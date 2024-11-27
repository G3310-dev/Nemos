import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:readmore/readmore.dart';

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
  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('BukaMataForum').doc(widget.docId).collection("Comment");
    final dbControl = DbWrapper();
    
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              SvgPicture.asset("asset/images/icon/logo.svg",
                colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn),
                width: 40,
                height: 40,
              ),
              const Spacer(),
              const TextWidget(size: 25.0, content: "Comment", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
              const Spacer(),
            ],
          ),
          Container(
            width: MediaQuery.sizeOf(context).width*0.9,
            padding: const EdgeInsets.only(left: 15),
            child: StreamBuilder(stream: collectionReference.orderBy("PostDate", descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.data!.size >= 1){
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    reverse: false,
                    children: snapshot.data!.docs.map((e) => Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      padding: const EdgeInsets.only(top: 5, bottom: 10),
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
          )
        ],
      ),
    );
  }
}
