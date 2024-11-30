import 'package:flutter/material.dart';

class LawExpert extends StatefulWidget {
  final int type;
  final double width;
  final double height;
  final double size;

  const LawExpert({super.key, required this.type, required this.width, required this.height, required this.size});

  @override
  State<LawExpert> createState() => _LawExpertState();
}

class _LawExpertState extends State<LawExpert> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(700),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF0004), Color(0xFFFFC300)],
          ),
          border: Border.all(
              color: const Color(0xFFD1D1D1),
              width: widget.type == 1? 0 : 2.5
          )
      ),
      width: widget.width,
      height:  widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(width: 10,),
          Text(
            "Law Expert",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                color: widget.type == 1? Colors.white : const Color(0XFF7A7A7A),
                fontSize: widget.size
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
