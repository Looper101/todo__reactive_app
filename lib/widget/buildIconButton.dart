import 'package:flutter/material.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';

IconButton buildIconButton(
    {BuildContext context, Function onPressed, Icon icon, Color color}) {
  return IconButton(
    padding: EdgeInsets.zero,
    icon: icon,
    color: color,
    iconSize: DeviceSizeConfig.longestSide * 0.03,
    onPressed: onPressed,
  );
}
