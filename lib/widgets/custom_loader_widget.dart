import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:  MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child:Image(
        image: AssetImage("assets/img/chargeBackground.gif"),
        )
      ),
    );
  }
}