import 'package:flutter/cupertino.dart';
import 'package:todo_stream/pallete.dart';

CupertinoButton buildDrawerButton({Function() onPress, String title}) {
  return CupertinoButton(
    borderRadius: BorderRadius.zero,
    color: Pallete.activeColor,
    child: Text(title),
    onPressed: onPress,
  );
}
