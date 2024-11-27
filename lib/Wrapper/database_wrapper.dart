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
  createForum(String username, String imageUrl, String title, String desc, String res, post) async {
    final String ID = _fire.collection("BukaMataForum").doc().id;
    try{
      _fire.collection("BukaMataForum").doc(ID).set({
        "Username": username,
        "Image": imageUrl,
        "Title": title,
        "Description": desc,
        "Resource": res,
        "Id": ID,
        "PostDate": post
      });
    } catch(e){
      log(e.toString());
    }
  }
  addComment(String username, String comment, String ID, String email, post) async {
    try{
      final String comID =  _fire.collection("BukaMataForum").doc(ID).collection("Comment").doc().id;
      _fire.collection("BukaMataForum").doc(ID).collection("Comment").doc(comID).set({
        "Username": username,
        "Comment": comment,
        "Email": email,
        "Id": comID,
        "PostDate": post
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
  deleteForum(String doc) async {
    try{
      _fire.collection("BukaMataForum").doc(doc).delete();
    } catch(e){
      log(e.toString());
    }
  }
  deleteComment(String ID, String comID) async {
    try{
      _fire.collection("BukaMataForum").doc(ID).collection("Comment").doc(comID).delete();
    } catch(e){
      log(e.toString());
    }
  }
}