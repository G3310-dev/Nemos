import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/forum_button.dart';
import 'package:nemos/Component/text_model.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Page/comment.dart';
import '../Page/testing.dart';
import '../Wrapper/database_wrapper.dart';

class Forum extends StatelessWidget {
  const Forum({super.key});


  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('BukaMataForum');

    return StreamBuilder(stream: collectionReference.orderBy("PostDate", descending: true).snapshots(),
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
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(size: 19.0, content: "${e['Title']}", type: 2, colour: 0xFF445B72, alignment: TextAlign.start),
                            const SizedBox(height: 5,),
                            ReadMoreText("${e['Description']}",
                                style: const TextStyle(color: Color(0xFF525252)),
                                trimMode: TrimMode.Line,
                                trimLines: 3,
                                colorClickableText: const Color(0xFF525252),
                                trimCollapsedText: 'Show more',
                                trimExpandedText: '...Show less',
                                moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(top: 10),
                                width: MediaQuery.sizeOf(context).width*0.9,
                                height: MediaQuery.sizeOf(context).height*0.22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(Uri.parse("${e['Image']}").toString(),),
                                      fit: BoxFit.cover
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 13,),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                      onTap: (){
                                        launchUrl(Uri.parse("${e['Resource']}"));
                                      },
                                      child: const ForumButton(image: "asset/images/icon/res.svg", desc: "Resource",)
                                  ),
                                  const SizedBox(height: 7,),
                                  GestureDetector(
                                      child: const ForumButton(image: "asset/images/icon/upvote.svg", desc: "0",)
                                  ),
                                  const SizedBox(height: 7,),
                                  GestureDetector(
                                    onTap: (){
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

    );
  }
}
