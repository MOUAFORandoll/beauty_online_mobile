import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart'; 

Widget toSvgIcon({
  required String icon,
  double? size = 20,
  Color? color,
  bool defaultFilter = true
}) {
  return Builder(
    builder: (context) {
      color ??= IconTheme.of(context).color;
      return SvgPicture.asset(
        icon,
        height: size,
        width: size,
        colorFilter: color != null && defaultFilter
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null
      );
    },
  );
}
