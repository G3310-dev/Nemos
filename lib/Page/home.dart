import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nemos/Component/action_bar.dart';
import 'package:nemos/Component/text_model.dart';

import '../Component/forum.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const ActionBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                            width: MediaQuery.sizeOf(context).width*0.9,
                            height: 350,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(35),
                                image: const DecorationImage(
                                    image: AssetImage("asset/images/picture/law.png"),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(left: 23, right: 14, bottom: 28),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                        color: Colors.white
                                    ),
                                  ),
                                  const Row(
                                    children: [
                                      TextWidget(size: 25.0, content: "Your Voice", type: 3, colour: 0xFFFFFFFF, alignment: TextAlign.start),
                                      TextWidget(size: 30.0, content: " Matters!", type: 2, colour: 0xFFFFFFFF, alignment: TextAlign.start),
                                    ],
                                  ),
                                  const TextWidget(size: 15.0, content: "Each person has a unique perspective, experience, and story that adds power to the movement for fairness and equality.", type: 3, colour: 0xFFFFFFFF, alignment: TextAlign.start)
                                ],
                              ),
                            )
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 23, top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 30,
                              margin: const EdgeInsets.only(right: 4),
                              height: 30,
                              child: SvgPicture.asset("asset/images/icon/fire.svg",
                                colorFilter: const ColorFilter.mode(Color(0xFFFF0004), BlendMode.srcIn),
                              ),
                            ),
                            const TextWidget(size: 25.0, content: "Hot Issue", type: 2, colour: 0xFFFF0004, alignment: TextAlign.center)
                          ],
                        ),
                      ),
                      const Forum(),
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () => {
                Navigator.pushNamed(context, "/addCase")
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20, bottom: 20,),
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xFF304457)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 37.0,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
