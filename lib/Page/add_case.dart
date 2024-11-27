import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:nemos/Page/confirmation.dart';
import '../Component/button.dart';
import '../Component/text_field.dart';
import '../Component/text_model.dart';

class AddCase extends StatelessWidget {
  const AddCase({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController resourceController = TextEditingController();

    return Scaffold(
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  const SizedBox(height: 30,),
                  const TextWidget(size: 40.0, content: "Vox Potens!", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
                  const TextWidget(size: 19.0, content: "Let's help with BukaMata!", type: 0, colour: 0xFF364D63, alignment: TextAlign.center),
                  const SizedBox(height: 30,),
                  FieldText(text: "Image URL (optional)", height: 50, desc: 'Image', obs: false, control: imageController, textType: 2,),
                  const SizedBox(height: 10,),
                  FieldText(text: "Title (required)", height: 50, desc: 'Title', obs: false, control: titleController, textType: 2,),
                  const SizedBox(height: 10,),
                  FieldText(text: "Description (required)", height: 200, desc: 'Description', obs: false, control: descController, textType: 1,),
                  const SizedBox(height: 10,),
                  FieldText(text: "Resource Link (required)", height: 50, desc: 'Resource', obs: false, control: resourceController, textType: 2,),
                  const SizedBox(height: 50,),
                  ButtonDef(
                    width: MediaQuery.sizeOf(context).width*0.85,
                    height: MediaQuery.sizeOf(context).height*0.05,
                    type: 1,
                    onTap: (){
                      if(titleController.text.isEmpty){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please enter case title"),
                          duration: Duration(milliseconds: 1000),
                        ));
                      }else{
                        if(descController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text("Please enter case description"),
                            duration: Duration(milliseconds: 1000),
                          ));
                        }else{
                          if(imageController.text.isEmpty){
                            if(Uri.parse(resourceController.text).isAbsolute){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Confirmation(
                                title: titleController.text, 
                                desc: descController.text, 
                                image: imageController.text,
                                res: resourceController.text,
                              )));
                            }else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Column(
                                  children: [
                                    Text("Your source URL is NOT VALID"),
                                    Text("Please include https:// for safety")
                                  ],
                                ),
                                duration: Duration(milliseconds: 2000),
                              ));
                            }
                          }else{
                            if(Uri.parse(resourceController.text).isAbsolute){
                              bool checkIfImage(String param) {
                                if (param == 'image/jpeg' || param == 'image/png' || param == 'image/gif' || param == 'image/webp' || param == 'image/jpg') {
                                  return true;
                                }
                                return false;
                              }
                              Future<bool> validateImage(String imageUrl) async {
                                http.Response res;
                                try {
                                  res = await http.get(Uri.parse(imageUrl));
                                } catch (e) {
                                  return false;
                                }
                                if (res.statusCode != 200){
                                  return false;
                                }else{
                                  Map<String, dynamic> data = res.headers;
                                  return checkIfImage(data['content-type']);
                                }
                              }
                              void validator() async {
                                bool isValid = await validateImage(imageController.text);

                                if (isValid) {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Confirmation(
                                    title: titleController.text,
                                    desc: descController.text,
                                    image: imageController.text,
                                    res: resourceController.text,
                                  )));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("Image is not valid"),
                                    duration: Duration(milliseconds: 700),
                                  ));
                                }
                              }
                              validator();
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Column(
                                  children: [
                                    Text("Your source URL is NOT VALID"),
                                    Text("Please include 'https://' for safety")
                                  ],
                                ),
                                duration: Duration(milliseconds: 2000),
                              ));
                            }
                          }
                        }
                      }
                    },
                    text: "Submit Case",
                    size: 18,
                  ),
                  const SizedBox(height: 7,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
