import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nemos/Component/text_model.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 30, bottom: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){},
            child: SvgPicture.asset("asset/images/icon/burger.svg",
              colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn),
              width: 40,
              height: 40,
            ),
          ),
          const Spacer(),
          const TextWidget(size: 25.0, content: "Nemos Buka Mata", type: 2, colour: 0xFF304457, alignment: TextAlign.center),
          const Spacer(),
        ],
      ),
    );
  }
}
