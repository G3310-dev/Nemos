import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class DbWrapper{
  final _fire = FirebaseFirestore.instance;

  create(String title, String desc) async {
    try{
      _fire.collection("users").add({
        "Name": title,
        "Age": desc,
      });
    } catch(e){
      log(e.toString());
    }
  }
  createForum(String username, String imageUrl, String title, String desc) async {
    try{
      _fire.collection("BukaMata").add({
        "Username": username,
        "Image": imageUrl,
        "Title": title,
        "Description": desc,
      });
    } catch(e){
      log(e.toString());
    }
  }
  read() async {
    try{
      // final data = await _fire.collection("BukaMata").get();
    } catch(e){
      log(e.toString());
    }
  }
  delete() async {
    try{
      _fire.collection("users").doc("fQbZ0wrIpphMVH7neEzO").delete();
    } catch(e){
      log(e.toString());
    }
  }
}