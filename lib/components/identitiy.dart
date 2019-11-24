import 'package:flutter/material.dart';

class Identity extends StatelessWidget {
  const Identity(this.name, this.iconPath, {Key key}) : super(key: key);

  final String name;
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black12
          ),
          child: Image(
            image: AssetImage(iconPath),
            width: 25,
            height: 25,
          ),
        ),
        Text(name, 
          style: TextStyle(fontSize: 20)
        )
      ],
    );
  }
}
