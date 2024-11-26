import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/forum_button.dart';
import 'package:nemos/Component/text_model.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class Confirmation extends StatefulWidget {
  final String desc;
  final String title;
  final String image;
  final String res;

  const Confirmation({super.key,
    required this.desc,
    required this.title,
    required this.image,
    required this.res
  });

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  User? user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                const TextWidget(size: 40.0, content: "Confirmation", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                const TextWidget(size: 19.0, content: "Your case will looked like this", type: 0, colour: 0xFF364D63, alignment: TextAlign.center),
                const SizedBox(height: 30,),
                Container(
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
                  width: MediaQuery.sizeOf(context).width*0.9,
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
                              TextWidget(size: 18.0, content: user?.email, type: 2, colour: 0xFF304457, alignment: TextAlign.start),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(size: 19.0, content: widget.title, type: 2, colour: 0xFF445B72, alignment: TextAlign.start),
                              const SizedBox(height: 5,),
                              ReadMoreText(widget.desc,
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
                                        image: NetworkImage(Uri.parse(widget.image).toString(),),
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
                                        launchUrl(Uri.parse(widget.res));
                                      },
                                        child: const ForumButton(image: "asset/images/icon/res.svg", desc: "Resource",)
                                    ),
                                    const SizedBox(height: 7,),
                                    GestureDetector(
                                        child: const ForumButton(image: "asset/images/icon/upvote.svg", desc: "0",)
                                    ),
                                    const SizedBox(height: 7,),
                                    GestureDetector(
                                        child: const ForumButton(image: "asset/images/icon/comment.svg", desc: "Comment",)
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
