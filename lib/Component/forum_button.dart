import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nemos/Component/text_model.dart';

class ForumButton extends StatefulWidget {
  final String image;
  final String desc;

  const ForumButton({super.key,
    required this.image,
    required this.desc,
  });

  @override
  State<ForumButton> createState() => _ForumButtonState();
}

class _ForumButtonState extends State<ForumButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(widget.image,
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(Color(0xFF304457), BlendMode.srcIn)
          ),
          const SizedBox(width: 5,),
          TextWidget(size: 20.0, content: widget.desc, type: 2, colour: 0xFF304457, alignment: TextAlign.center)
        ],
      ),
    );
  }
}
