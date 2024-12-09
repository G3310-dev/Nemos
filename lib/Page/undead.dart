import 'package:flutter/material.dart';
import 'package:nemos/Component/text_model.dart';
import 'package:provider/provider.dart';

import '../Wrapper/auth_wrapper.dart';

class Undead extends StatelessWidget {
  const Undead({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextWidget(size: 40.0, content: "404", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
              const TextWidget(size: 20.0, content: "The page you're looking for is not found", type: 2, colour: 0xFF7A7A7A, alignment: TextAlign.center),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: () {
                  context.read<AuthWrap>().signOut();
                  Navigator.pushNamedAndRemoveUntil(context, "/getStart", (e) => false);
                },
                child: const TextWidget(size: 15.0, content: "#Log me out!", type: 2, colour: 0xFF364D63, alignment: TextAlign.center),
              )
            ],
          ),
        ),
      ),
    );
  }
}
