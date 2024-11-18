import 'package:flutter/material.dart';
import 'package:nemos/Component/textModel.dart';

class Undead extends StatelessWidget {
  const Undead({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width*0.8,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(size: 40.0, content: "404", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
              TextWidget(size: 20.0, content: "The page you're looking for is not found", type: 2, colour: 0xFF7A7A7A, alignment: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
