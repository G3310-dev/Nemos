import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nemos/Component/text_model.dart';

class Forum extends StatelessWidget {
  const Forum({super.key});


  @override
  Widget build(BuildContext context) {
    final CollectionReference collectionReference = FirebaseFirestore.instance.collection('users');

    return StreamBuilder(stream: collectionReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(snapshot.data!.size >= 1){
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          reverse: false,
          children: snapshot.data!.docs.map((e) => Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
            padding: const EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                ListTile(
                    title:
                    Container(
                      width: MediaQuery.sizeOf(context).width*0.9,
                      height: 300,
                      decoration: const BoxDecoration(),
                    )
                ),
              ],
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
