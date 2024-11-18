import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nemos/Component/button.dart';
import 'package:nemos/Component/textModel.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                child: Image.asset('asset/images/picture/welcoming.png',
                  filterQuality: FilterQuality.high,
                  isAntiAlias: true,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(left: 27.0, right: 30.0, top: 20.0, bottom: MediaQuery.sizeOf(context).height*0.08),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextWidget(
                    size: 30.0,
                    content: "Solve Injustice with",
                    type: 1,
                    colour: 0xFF304457,
                    alignment: TextAlign.left,),
                  const TextWidget(
                    size: 37.0,
                    content: "Nemos!",
                    type: 2,
                    colour: 0xFF304457,
                    alignment: TextAlign.left,),
                  const SizedBox(height: 10,),
                  const TextWidget(
                      size: 19.0,
                      content: "Welcome to Nemos, a platform to help you confront and address the injustices you experience. We believe that everyone matters, and together we can create a wave of change.",
                      type: 1,
                      colour: 0xFF364D63,
                      alignment: TextAlign.left),
                  SizedBox(height: MediaQuery.sizeOf(context).height*0.05,),
                  Center(
                    child: ButtonDef(
                        width: MediaQuery.sizeOf(context).width*0.9,
                        height: MediaQuery.sizeOf(context).height*0.04,
                        type: 1,
                        onTap: (){
                          if (kDebugMode) {
                            print("hello");
                          }
                        },
                        text: "Sign In", size: 15),
                  ),
                  const SizedBox(height: 3,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0)
                          ),
                          child: const Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 2.0,
                            height: 5.0,
                            color: Color(0x807A7A7A),
                          ),
                        ),
                      ),
                      const Text('or', style: TextStyle(color: Color(0xFF7A7A7A)),),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0)
                          ),
                          child: const Divider(
                            indent: 10,
                            endIndent: 10,
                            thickness: 2.0,
                            height: 5.0,
                            color: Color(0x807A7A7A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3,),
                  Center(
                    child: ButtonDef(
                        width: MediaQuery.sizeOf(context).width*0.9,
                        height: MediaQuery.sizeOf(context).height*0.04,
                        type: 2,
                        onTap: (){
                          if (kDebugMode) {
                            print("hello");
                          }
                        },
                        text: "Sign Up", size: 15),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
