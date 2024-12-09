import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nemos/Component/text_model.dart';

class ActionBar extends StatefulWidget {
  final String title;

  const ActionBar({super.key, required this.title});

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.only(top: 30, left: 15, right: 30, bottom: 20),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              return Scaffold.of(context).openDrawer();
            },
            child: SvgPicture.asset("asset/images/icon/burger.svg",
              colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn),
              width: 40,
              height: 40,
            ),
          ),
          const Spacer(),
          TextWidget(size: 20.0, content: widget.title, type: 2, colour: 0xFF304457, alignment: TextAlign.center),
          const Spacer(),
        ],
      ),
    );
  }
}
