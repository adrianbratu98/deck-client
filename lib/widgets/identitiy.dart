import 'package:flutter/material.dart';

class Identity extends StatelessWidget {
  const Identity(this.name, this.iconName, this.size, {Key key}) : super(key: key);

  final String name;
  final String iconName;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black12
            ),
            child: Image(
              image: AssetImage("images/${iconName.substring(iconName.lastIndexOf('.') + 1)}.png"),
              width: size,
              height: size,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              name.toUpperCase(),
              style: TextStyle(fontSize: size / 2)
            ),
          )
        ],
      ),
    );
  }
}
