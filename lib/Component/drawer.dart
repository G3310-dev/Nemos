import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/text_model.dart';

class DrawerDef extends StatefulWidget {
  const DrawerDef({super.key});

  @override
  State<DrawerDef> createState() => _DrawerDefState();
}

class _DrawerDefState extends State<DrawerDef> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('UserData').doc('${user?.email}').collection('Username');

    return Drawer(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20,),
              width: 70,
              height: 70,
              child: SvgPicture.asset("asset/images/icon/logo.svg",
                  colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn)
              ),
            ),
            StreamBuilder(
                stream: collectionReference.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.data!.size >= 1) {
                    return Center(
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: snapshot.data!.docs.map((e) => Center(
                          child: TextWidget(size: 20.0, content: "${e['Username']}", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                        )).toList(),
                      ),
                    );
                  }
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height*0.04,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(size: 20.0, content: "Unknown User", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                      ],
                    ),
                  );
                }
            ),
            TextWidget(size: 15.0, content: user?.email ?? "No Email presents", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
            const SizedBox(height: 5,),
            const SizedBox(height: 30,),
            const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1.5,
              height: 5.0,
              color: Color(0x807A7A7A),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () {
                var route = ModalRoute.of(context);

                if(route?.settings.name != "/"){
                  Navigator.pushReplacementNamed(context, "/");
                  Scaffold.of(context).closeDrawer();
                }else{
                  Scaffold.of(context).closeDrawer();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_red_eye_rounded,
                    color: Color(0xFF304457),
                  ),
                  SizedBox(width: 10,),
                  TextWidget(size: 20.0, content: "BukaMata", type: 1, colour: 0xFF304457, alignment: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1.5,
              height: 5.0,
              color: Color(0x807A7A7A),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: () async{
                var route = ModalRoute.of(context);

                if(route?.settings.name != "/literaKum"){
                  Navigator.pushReplacementNamed(context, "/literaKum");
                  Scaffold.of(context).closeDrawer();
                }else{
                  Scaffold.of(context).closeDrawer();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.library_books_rounded,
                    color: Color(0xFF304457),
                  ),
                  SizedBox(width: 10,),
                  TextWidget(size: 20.0, content: "LiteraKum", type: 1, colour: 0xFF304457, alignment: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1.5,
              height: 5.0,
              color: Color(0x807A7A7A),
            ),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                var route = ModalRoute.of(context);

                if(route?.settings.name != "/setting"){
                  Navigator.pushReplacementNamed(context, "/setting");
                  Scaffold.of(context).closeDrawer();
                }else{
                  Scaffold.of(context).closeDrawer();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person,
                    color: Color(0xFF304457),
                  ),
                  SizedBox(width: 10,),
                  TextWidget(size: 20.0, content: "Profile", type: 1, colour: 0xFF304457, alignment: TextAlign.center),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            const Divider(
              indent: 20,
              endIndent: 20,
              thickness: 1.5,
              height: 5.0,
              color: Color(0x807A7A7A),
            ),
          ],
        ),
      ),
    );
  }
}
