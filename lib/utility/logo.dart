import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;
  final double width;
  final double fontSize;

  const Logo({Key? key, required this.width, required this.height, required this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(

          // width: width,
          // height: height,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            border: Border.all(),
            boxShadow: const [BoxShadow(blurRadius: 10)],
            borderRadius: BorderRadius.circular(25)
          ),
          child: Image(
            image: AssetImage("images/quizi.png"),
            width: width,
            height: height,
          ),
        ),
        // Text("Quizzy",style: TextStyle(
        //   fontSize: fontSize,
        //   fontWeight: FontWeight.bold
        // ),)
      ],
    );
  }
}
