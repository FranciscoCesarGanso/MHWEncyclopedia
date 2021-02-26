import 'package:flutter/material.dart';
import 'package:mhencicopledia/helpers/stroke.dart';
class CustomTab extends StatelessWidget {
  final String texto;
  final Color gradienteStart;
  final Color gradienteEnd;

  const CustomTab({@required this.texto, this.gradienteStart=Colors.black, this.gradienteEnd=Colors.white});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
      margin: EdgeInsets.only(bottom: 5),
      decoration:BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.black, width: 2, style: BorderStyle.solid)),
        shape: BoxShape.rectangle,
        gradient: LinearGradient(
          colors: [
            this.gradienteStart,
            this.gradienteEnd,
          ]
        )
      ),
      child: Text(
        this.texto,
        style:Theme.of(context).textTheme.headline1,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
      ),
    );   
  }
}