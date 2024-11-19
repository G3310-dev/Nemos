import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nemos/Component/button.dart';
import 'package:nemos/Component/orline.dart';
import 'package:nemos/Component/text_field.dart';
import 'package:nemos/Wrapper/auth_wrapper.dart';
import 'package:provider/provider.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.sizeOf(context).width*0.8,
                    child: const OrLine()
                ),
                const SizedBox(height: 30,),
                FieldText(text: "Email", height: 50, desc: 'Email', obs: false, control: emailController,),
                const SizedBox(height: 10,),
                FieldText(text: "Password", height: 50, desc: 'Password', obs: true, control: passwordController,),
                const SizedBox(height: 50,),
                ButtonDef(
                  width: MediaQuery.sizeOf(context).width*0.85,
                  height: MediaQuery.sizeOf(context).height*0.05,
                  type: 1,
                  onTap: (){
                    context.read<AuthWrap>().signIn(
                      context: context,
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
                  },
                  text: "Sign In",
                  size: 18,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
