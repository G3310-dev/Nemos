import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/text_model.dart';

class DrawerDef extends StatelessWidget {
  const DrawerDef({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 20),
                width: 70,
                height: 70,
                child: SvgPicture.asset("asset/images/icon/logo.svg",
                    colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn)
                ),
              ),
              TextWidget(size: 15.0, content: user?.email, type: 1, colour: 0xFF304457, alignment: TextAlign.center),
              TextWidget(size: 10.0, content: user?.uid, type: 2, colour: 0xFF304457, alignment: TextAlign.center),
              const SizedBox(height: 5,),
              const Divider(
                indent: 10,
                endIndent: 10,
                thickness: 2.0,
                height: 5.0,
                color: Color(0x807A7A7A),
              ),
            ],
          )
        ],
      ),
    );
  }
}
